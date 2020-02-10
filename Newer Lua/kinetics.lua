-- Advanced Motions Lua

Kinetics = {}

Kinetics.heights = {}

Kinetics.heights.head = 0.8
Kinetics.heights.shoulders = 0.6
Kinetics.heights.knees = 0.375

Kinetics.transit = {}

Kinetics.transit.active = false

Kinetics.transit.start = {}
Kinetics.transit.start.x,
Kinetics.transit.start.y,
Kinetics.transit.start.z,
Kinetics.transit.start.facing = nil

Kinetics.transit.sequence = {}
Kinetics.transit.sequence.x = {}
Kinetics.transit.sequence.y = {}
Kinetics.transit.sequence.z = {}
Kinetics.transit.sequence.facing = {}
Kinetics.transit.sequence.count = 1
Kinetics.transit.sequence.duration = 0

Kinetics.transit.finish = {}
Kinetics.transit.finish.x = nil
Kinetics.transit.finish.y = nil
Kinetics.transit.finish.z = nil
Kinetics.transit.finish.facing = nil

Kinetics.transit.after = nil

function Kinetics.jump(charge)

	local p = Player.me
	
	local force = charge * Player.jump.power
	
	p:accelerate(p.direction, 0.0, force)
	
end

function Kinetics.clearTransition()

	Kinetics.transit.start.x = nil
	Kinetics.transit.start.y = nil
	Kinetics.transit.start.z = nil
	Kinetics.transit.start.facing = nil

	Kinetics.transit.sequence.x = {}
	Kinetics.transit.sequence.y = {}
	Kinetics.transit.sequence.z = {}
	Kinetics.transit.sequence.facing = {}
	Kinetics.transit.sequence.count = 1
	Kinetics.transit.sequence.duration = 0

	Kinetics.transit.finish.x = nil
	Kinetics.transit.finish.y = nil
	Kinetics.transit.finish.z = nil
	Kinetics.transit.finish.facing = nil
	
	Kinetics.transit.active = false
	
	Kinetics.transit.after = nil
	
end

function Kinetics.engageTransition(duration, x, y, z, facing, after)

	if Kinetics.transit.active then
		return
	end
	
	if after then
		Kinetics.transit.after = after
	end

	Kinetics.transit.sequence.duration = duration
	
	Kinetics.transit.start.x = Player.me.x
	Kinetics.transit.start.y = Player.me.y
	Kinetics.transit.start.z = Player.me.z
	Kinetics.transit.start.facing = Player.me.direction
	
	Kinetics.transit.finish.x = x
	Kinetics.transit.finish.y = y
	Kinetics.transit.finish.z = z
	Kinetics.transit.finish.facing = facing
	
	local df = Kinetics.transit.finish.facing - Kinetics.transit.start.facing
	
	if df > 180 then
		df = (df - 360)
	elseif df < -180 then
		df = df + 360
	end
	
	df = df / duration

	local dx = (Kinetics.transit.finish.x - Kinetics.transit.start.x) / duration
	local dy = (Kinetics.transit.finish.y - Kinetics.transit.start.y) / duration
	local dz = (Kinetics.transit.finish.z - Kinetics.transit.start.z) / duration
	
	for i = 1, duration, 1 do
		
		Kinetics.transit.sequence.x[i] = Kinetics.transit.start.x + (dx * i)
		Kinetics.transit.sequence.y[i] = Kinetics.transit.start.y + (dy * i)
		Kinetics.transit.sequence.z[i] = Kinetics.transit.start.z + (dz * i)
		Kinetics.transit.sequence.facing[i] = (Kinetics.transit.start.facing + (df * i)) % 360
		
	end
	
	Kinetics.transit.sequence.count = 1
	
	Kinetics.transit.active = true

end

function Kinetics.transition()
	
	local seq = Kinetics.transit.sequence
	local t = Kinetics.transit.sequence.count
	local p = getPolygonAtLoc(seq.x[t], seq.y[t], seq.z[t])
	
	Player.me:position(Kinetics.transit.sequence.x[t], Kinetics.transit.sequence.y[t], Kinetics.transit.sequence.z[t], Players[0].polygon)
	Player.me.direction = Kinetics.transit.sequence.facing[t]
	
	if Kinetics.transit.sequence.count == Kinetics.transit.sequence.duration then
		
		Kinetics.transit.after()
		
		Kinetics.clearTransition()

	else
		
		Kinetics.transit.sequence.count = Kinetics.transit.sequence.count + 1
		
	end
	
end

function Kinetics.ladder(stage)

	local ladder = Player.ladder.id

	if stage ~= "post" then
		
		if not Player.me.head_below_media then
			
			ladder.polygon.media = nil
			
		end
		
		Player.ladder.z = Player.me.z
		
		Player.me:position(ladder.climbAxis.x, ladder.climbAxis.y, ladder.z, ladder.polygon)
		
	else
		
		local df = ((ladder.facing + 180) % 360) - Player.me.direction
		
		if df > 180 then
			df = (df - 360)
		elseif df < -180 then
			df = df + 360
		end
		
		local bearing = (Player.me.direction + ladder.facing - 180) % 360
		
		Players[0].overlays[3].text = df
		
		if df < -100 then
			Player.me.direction = Player.me.direction + (df + 100)
		elseif df > 100 then
			Player.me.direction = Player.me.direction - (100 - df)
		end
		
		ladder.polygon.media = ladder.media
		
		local vs = (math.max(math.min(Player.me.pitch, 45), -45) / 45) * Player.me.internal_velocity.forward / 2
		
		local climbHeight = math.min(Player.ladder.z + vs, ladder.maxHeadroom)
	
		Player.me:position(ladder.climbAxis.x, ladder.climbAxis.y, climbHeight, ladder.polygon)
		
		if Player.me.z < ladder.z then
			Player.ladder.climbing = false
		elseif Player.me.z + Kinetics.heights.shoulders > ladder.top then
			Player.ladder.climbing = false
			Kinetics.transit.after = function () end
			Kinetics.engageTransition(30, ladder.adjacent.x, ladder.adjacent.y, ladder.adjacent.polygon.z, ladder.facing + 180)
		end
		
	end
	
end

function Kinetics.evaluate(o, x, y, z, polygon)
	
	if is_polygon_floor(o) then
		
		return Kinetics.climb.floor(polygon)
		
	elseif is_side(o) then
		
		Players.print("Checking side motion...")
		
		if o.type ~= "full" and o.type ~= "high" then
		
	        if o.line.clockwise_side == o then
	           target_polygon = o.line.counterclockwise_polygon
	        else
	           target_polygon = o.line.clockwise_polygon
	        end
		
	        if target_polygon then
				return Kinetics.climb.wall(o, z, target_polygon)
			end
			
		end
			
	else
		return false
	end
	
	return false
	
end

function Kinetics.heights.fromShoulders()

	local z

	if Player.ladder.climbing == true then
		
		z = Player.ladder.z

	else

		z = Player.me.z

	end
	
	return z + Kinetics.heights.shoulders

end

function Kinetics.heights.fromKnees()

	local z

	if Player.ladder.climbing == true then
		
		z = Player.ladder.z

	else

		z = Player.me.z

	end
	
	return z + Kinetics.heights.knees

end

Kinetics.climb = {}

function Kinetics.climb.wall(side, z, polygon)
	
	local p = Player.me
	
	Players.print("Attempting wall climb...")
	
	if p.pitch < 0 then
		Players.print("Fail, pitch < 0.")
		return false
	elseif getPolyZSpan(polygon) < 1 then
		Players.print("Fail, can't fit.")
		return false
	elseif Kinetics.heights.fromKnees() - polygon.z > Kinetics.heights.knees then
		Players.print("Fail, ledge too low.")
		return false
	elseif polygon.z - Kinetics.heights.fromShoulders() > 0.5 then
		Players.print("Fail, ledge too high.")
		return false
	end
	
	if Player.ladder.climbing == true then
		
		Player.ladder.climbing = false
		Kinetics.ladder("post")
		
	end
	
	p:accelerate(p.direction, 0.01, 0.1)
	
	return true
	
end

function Kinetics.climb.floor(polygon)

	local p = Player.me
	
	local startHeight = Kinetics.heights.fromKnees()
	
	if p.feet_below_media then
		if p.z > p.polygon.z then -- If you are floating
			startHeight = Kinetics.heights.fromShoulders()
		end
	end
	
	if getPolyZSpan(polygon) < 1 then
		return false
	elseif polygon.z - p.z < Kinetics.heights.knees then
		return false
	end
	
	if polygon.z - startHeight < 0.5 then
		p:accelerate(p.direction, 0.01, 0.05)
		
		return true
		
	end
	
	return false
	
end