function radToCart(angle, radius)
	local x = math.cos(math.rad(angle)) * radius
	local y = math.sin(math.rad(angle)) * radius
	return x, y
end

function cartToRad(x, y)

	local scalar = math.sqrt(x * x + y * y)
	
	local nx = 0
	local ny = 0
	
	if scalar ~= 0 then
		nx = x / scalar
		ny = y / scalar
	else
		nx = 0
		ny = 0
	end	
	
	local angle = math.deg(math.atan2(ny, nx))
	if angle < 0 then angle = angle + 360 end
	
	return scalar, angle
	
end

function getSign(n)
	if n > 0 then
		return 1
	elseif n < 0 then
		return -1
	else
		return 0
	end
end

function getDistance(x, y, z, object)
	
	local d2 = math.sqrt((object.x - x)^2 + (object.y - y)^2)
	return math.sqrt(d2^2 + (object.z - z)^2)
	
end

function getBearing(from, to)
	
	local x = to.x - from.x
	local y = to.y - from.y
	local theta = math.deg(math.atan(y/x))
	if x < 0 then
		return theta + 180
	elseif y < 0 then
		return theta + 360
	else
		return theta
	end
	
end

-- Takes a comma separated value string and transfers values into Lua table (as strings).
-- Use == "true" and tonumber() to get boolean and numerical values, or suffer type mismatches.
-- Use semicolons inside of a cell to delineate a subtable.
-- Achtung! This does *not* filter additional whitespace from beginning or end of values, you have been warned.

function filterCSVLine(source)

	local t = {}
	
	for chunk in source:gmatch("[^,]+") do
	
		if chunk:find(";") then -- Semicolon is subcell delimeter...
			
			local u = {}
			for crumb in chunk:gmatch("[^;]+") do
				table.insert(u, crumb)
			end
			table.insert(t, u)
			
		else
			
			table.insert(t, chunk)
			
		end
	
	end
	
	return t
	
end


function swapScenery(oldBusted, newType)
	
	local x, y, z, f, p = oldBusted.x, oldBusted.y, oldBusted.z, oldBusted.facing, oldBusted.polygon
	
	local parent = oldBusted._parent or nil
	
	oldBusted:delete()
	
	local newHotness = Scenery.new(x, y, z, p, newType)
	newHotness.facing = f
	newHotness._parent = parent
	
	return newHotness

end
	
	
	