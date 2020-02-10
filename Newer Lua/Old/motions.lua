-- Advanced Motions Lua

motions = {}

motions.heights = {}

motions.heights.head = 0.8
motions.heights.shoulders = 0.6
motions.heights.knees = 0.375

motions.transit = {}

motions.transit.active = false

motions.transit.start = {}
motions.transit.start.x = nil
motions.transit.start.y = nil
motions.transit.start.z = nil
motions.transit.start.facing = nil

motions.transit.sequence = {}
motions.transit.sequence.x = {}
motions.transit.sequence.y = {}
motions.transit.sequence.z = {}
motions.transit.sequence.facing = {}
motions.transit.sequence.count = 1
motions.transit.sequence.duration = 0

motions.transit.finish = {}
motions.transit.finish.x = nil
motions.transit.finish.y = nil
motions.transit.finish.z = nil
motions.transit.finish.facing = nil

motions.transit.after = nil

function motions.jump(charge)

	local p = Player.me
	
	local force = charge * Player.jump.power
	
	p:accelerate(p.direction, 0.0, force)
	
end

function motions.clearTransition()

	motions.transit.start.x = nil
	motions.transit.start.y = nil
	motions.transit.start.z = nil
	motions.transit.start.facing = nil

	motions.transit.sequence.x = {}
	motions.transit.sequence.y = {}
	motions.transit.sequence.z = {}
	motions.transit.sequence.facing = {}
	motions.transit.sequence.count = 1
	motions.transit.sequence.duration = 0

	motions.transit.finish.x = nil
	motions.transit.finish.y = nil
	motions.transit.finish.z = nil
	motions.transit.finish.facing = nil
	
	motions.transit.active = false
	
	motions.transit.after = nil
	
end

function motions.engageTransition(duration, x, y, z, facing, after)

	if motions.transit.active then
		return
	end
	
	if after then
		motions.transit.after = after
	end

	motions.transit.sequence.duration = duration
	
	motions.transit.start.x = Player.me.x
	motions.transit.start.y = Player.me.y
	motions.transit.start.z = Player.me.z
	motions.transit.start.facing = Player.me.direction
	
	motions.transit.finish.x = x
	motions.transit.finish.y = y
	motions.transit.finish.z = z
	motions.transit.finish.facing = facing
	
	local df = motions.transit.finish.facing - motions.transit.start.facing
	
	if df > 180 then
		df = (df - 360)
	elseif df < -180 then
		df = df + 360
	end
	
	df = df / duration

	local dx = (motions.transit.finish.x - motions.transit.start.x) / duration
	local dy = (motions.transit.finish.y - motions.transit.start.y) / duration
	local dz = (motions.transit.finish.z - motions.transit.start.z) / duration
	
	for i = 1, duration, 1 do
		
		motions.transit.sequence.x[i] = motions.transit.start.x + (dx * i)
		motions.transit.sequence.y[i] = motions.transit.start.y + (dy * i)
		motions.transit.sequence.z[i] = motions.transit.start.z + (dz * i)
		motions.transit.sequence.facing[i] = (motions.transit.start.facing + (df * i)) % 360
		
	end
	
	motions.transit.sequence.count = 1
	
	motions.transit.active = true

end

function motions.transition()
	
	local seq = motions.transit.sequence
	local t = motions.transit.sequence.count
	local p = getPolygonAtLoc(seq.x[t], seq.y[t], seq.z[t])
	
	Player.me:position(motions.transit.sequence.x[t], motions.transit.sequence.y[t], motions.transit.sequence.z[t], Players[0].polygon)
	Player.me.direction = motions.transit.sequence.facing[t]
	
	if motions.transit.sequence.count == motions.transit.sequence.duration then
		
		motions.transit.after()
		
		motions.clearTransition()

	else
		
		motions.transit.sequence.count = motions.transit.sequence.count + 1
		
	end
	
end

function motions.ladder(stage)

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
		elseif Player.me.z + motions.heights.shoulders > ladder.top then
			Player.ladder.climbing = false
			motions.transit.after = function () end
			motions.engageTransition(30, ladder.adjacent.x, ladder.adjacent.y, ladder.adjacent.p.z, ladder.facing + 180)
		end
		
	end
	
end

function motions.evaluate(o, x, y, z, polygon)
	
	if is_polygon_floor(o) then
		
		return motions.climb.floor(polygon)
		
	elseif is_side(o) then
		
		Players.print("Checking side motion...")
		
		if o.type ~= "full" and o.type ~= "high" then
		
	        if o.line.clockwise_side == o then
	           target_polygon = o.line.counterclockwise_polygon
	        else
	           target_polygon = o.line.clockwise_polygon
	        end
		
	        if target_polygon then
				return motions.climb.wall(o, z, target_polygon)
			end
			
		end
			
	else
		return false
	end
	
	return false
	
end

function motions.heights.fromShoulders()

	local z

	if Player.ladder.climbing == true then
		
		z = Player.ladder.z

	else

		z = Player.me.z

	end
	
	return z + motions.heights.shoulders

end

function motions.heights.fromKnees()

	local z

	if Player.ladder.climbing == true then
		
		z = Player.ladder.z

	else

		z = Player.me.z

	end
	
	return z + motions.heights.knees

end

motions.climb = {}

function motions.climb.wall(side, z, polygon)
	
	local p = Player.me
	
	Players.print("Attempting wall climb...")
	
	if p.pitch < 0 then
		Players.print("Fail, pitch < 0.")
		return false
	elseif getPolyZSpan(polygon) < 1 then
		Players.print("Fail, can't fit.")
		return false
	elseif motions.heights.fromKnees() - polygon.z > motions.heights.knees then
		Players.print("Fail, ledge too low.")
		return false
	elseif polygon.z - motions.heights.fromShoulders() > 0.5 then
		Players.print("Fail, ledge too high.")
		return false
	end
	
	if Player.ladder.climbing == true then
		
		Player.ladder.climbing = false
		motions.ladder("post")
		
	end
	
	p:accelerate(p.direction, 0.01, 0.1)
	
	return true
	
end

function motions.climb.floor(polygon)

	local p = Player.me
	
	local startHeight = motions.heights.fromKnees()
	
	if p.feet_below_media then
		if p.z > p.polygon.z then -- If you are floating
			startHeight = motions.heights.fromShoulders()
		end
	end
	
	if getPolyZSpan(polygon) < 1 then
		return false
	elseif polygon.z - p.z < motions.heights.knees then
		return false
	end
	
	if polygon.z - startHeight < 0.5 then
		p:accelerate(p.direction, 0.01, 0.05)
		
		return true
		
	end
	
	return false
	
end