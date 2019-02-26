-- Advanced Motions Lua

motions = {}

motions.heights = {}

motions.heights.head = 0.8
motions.heights.shoulders = 0.6
motions.heights.knees = 0.375

function motions.jump(charge)

	local p = Player.me
	
	local force = charge * Player.jump.power
	
	p:accelerate(p.direction, 0.0, force)
	
end

function motions.evaluate(o, x, y, z, polygon)
	
	if is_polygon_floor(o) then
		
		return motions.climb.floor(polygon)
		
	elseif is_side(o) then
		
		Players.print("Checking side motion...")
		Players.print(o.type)
		
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

	local z = Players[0].z
	
	return z + motions.heights.shoulders

end

function motions.heights.fromKnees()

	local z = Players[0].z
	
	return z + motions.heights.knees

end

motions.climb = {}

function motions.climb.wall(side, z, polygon)
	
	local p = Player.me
	
	startHeight = motions.heights.fromShoulders()
	
	Players.print("Attempting wall climb...")
	
	if p.pitch < 0 then
		Players.print("Fail, pitch < 0.")
		return false
	elseif getPolyZSpan(polygon) < 1 then
		Players.print("Fail, can't fit.")
		return false
	elseif polygon.z - p.z < motions.heights.knees then
		Players.print("Fail, ledge too low.")
		return false
	elseif polygon.z - startHeight > 0.5 then
		Players.print("Fail, ledge too high.")
		return false
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