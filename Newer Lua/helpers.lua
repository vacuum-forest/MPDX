function tickMod(n)

	if Game.ticks % n == 0 then
		return true
	end
	
	return false

end


function radToCart(angle, radius)
	
	if (radius == nil) or (angle == nil) then
		return false
	end
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


function offsetRadial(x, y, angle, radius)

	local xr, yr = radToCart(angle, radius)
	
	return x + xr, y + yr
	
end


function getLineCenter(line)
	
	local xc, yc
	
	local x1, y1 = line.endpoints[0].x, line.endpoints[0].y
	local x2, y2 = line.endpoints[1].x, line.endpoints[1].y
	
	local dx = math.abs(x1 - x2) / 2
	local dy = math.abs(y1 - y2) / 2
	
	if x1 < x2 then
		xc = x1 + dx
	else
		xc = x2 + dx
	end
	
	if y1 < y2 then
		yc = y1 + dy
	else
		yc = y2 + dy
	end
	
	return xc, yc
	
end


function getIntersection(a1, a2, b1, b2)

	local d = (a1.x - a2.x) * (b1.y - b2.y) - (a1.y - a2.y) * (b1.x - b2.x)
	local a = a1.x * a2.y - a1.y * a2.x
	local b = b1.x * b2.y - b1.y * b2.x

	return (a * (b1.x - b2.x) - (a1.x - a2.x) * b) / d, (a * (b1.y - b2.y) - (a1.y - a2.y) * b) / d

end


function bAND(a, b)

	local z = 0

	for i = 0, 31, 1 do
		local x = (a / 2) - math.floor(a / 2)
		local y = (b / 2) - math.floor(b / 2)
		z = z + (math.floor(x + y) * 2^i)
		a = math.floor(a / 2)
		b = math.floor(b / 2)
	end
	
	return z
	
end


function bXOR(a, b)

	local z = 0

	for i = 0, 31, 1 do
		local x = (a / 2) + (b / 2)
		local y = math.floor(x)
		z = z + (2 * (math.max(x,y) - math.min(x,y)) * 2^i)
		a = math.floor(a / 2)
		b = math.floor(b / 2)
	end
	
	return z
	
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


function getSlantDistance(x, y, z, object)
	
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


function getPolygonAtLoc(x, y, z)

	if z ~= nil then

		for p in Polygons() do
		
			if p:contains(x, y, z) then
				return p
			end
		
		end
	
	else
		
		local results = {}
		
		for p in Polygons() do
		
			if p:contains(x, y) then
				table.insert(results, p)
			end
		
		end
		
		if # results >= 1 then
			
			return results
			
		end
		
	end
	
	Players.print("No Poly")
	
	assert(# results >= 1, "Could not find polygon!")
	
	return nil
	
end


--[[
local found = { Polygons[9999] }

local filter = function(polygon)

	if polygon.type ~= "zone border" then
		return true
	end

	return false

end

gatherPolygonsRecursive(found, found[1], filter)
]]

function gatherPolygonsRecursive(basket, polygon, criteria)
	
	for p in polygon:adjacent_polygons() do
		
		if criteria(p) then
			
			if not inTable(basket, p) then
				table.insert(basket, p)
				gatherPolygonsRecursive(basket, p, criteria)
			end
			
		end
		
	end
	
end


function normalizeAngle(angle)

	if math.abs(angle) >= 360 then
		angle = angle % 360
	end
	
	if angle < 0 then
		angle = angle + 360
	end
	
	return angle
	
end


function createScenery(type, position)
	
	assert(tonumber(position.facing) == position.facing, position.polygon.index)

	local newScenery = Scenery.new(position.x, position.y, position.z, position.polygon, SceneryTypes[type])
	newScenery:position(position.x, position.y, position.z, position.polygon)
	newScenery.facing = position.facing
	
	return newScenery
	
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
	
	
function getPolyZSpan(polygon)
	
	return polygon.ceiling.height - polygon.floor.height
	
end


function getSidePart(side, z) -- Lovingly cribbed from VML (Irons/Smith) [presumably] by way of Vasara (Hopper/Ares Ex Machina)

    if side.type == "full" then
       local opposite_polygon
       if side.line.clockwise_side == side then
          opposite_polygon = side.line.counterclockwise_polygon
       else
          opposite_polygon = side.line.clockwise_polygon
       end
       if opposite_polygon then
          return "transparent"
       else
          return "primary"
       end
    elseif side.type == "high" then
       if z > side.line.lowest_adjacent_ceiling then
          return "primary"
       else
          return "transparent"
       end
    elseif side.type == "low" then
       if z < side.line.highest_adjacent_floor then
          return "primary"
       else
          return "transparent"
       end
    else
       if z > side.line.lowest_adjacent_ceiling then
          return "primary"
       elseif z < side.line.highest_adjacent_floor then
          return "secondary"
       else
          return "transparent"
       end
    end
	
end


function getPosition(object)
	
	local position = {}
	
	if object.x then position.x = object.x end
	if object.y then position.y = object.y end
	if object.z then position.z = object.z end
	if object.facing then position.facing = object.facing end
	if object.polygon then position.polygon = object.polygon end
	
	return position
	
end


function findByID(collection, id, maxResults)
	
	local results = {}
	
	for k, v in ipairs(collection) do
		
		if collection[k].id == id then
			table.insert(results, collection[k])
		end
		
		if maxResults then
			if # results >= maxResults then
				return results
			end
		end

	end
	
	if # results >= 1 then
	
		if not maxResults then
			return results[1]
		else
			return results
		end
		
	end
	return nil
	
end


function inTable(t, q)
	
	for k, v in pairs(t) do
		if v == q then return true end
	end
	
	return false
	
end


function mergeTable(first, second)

	if (first == nil) or (second == nil) then return false end

	for k, v in pairs(second) do
	
		if not inTable(first, v) then
			table.insert(first, v)
		end
	
	end

	return first
	
end


function mergeTableKeys(first, second)

	if (first == nil) or (second == nil) then return false end

	for k, v in pairs(second) do
	
		if not first[k] then
			first[k] = v
		end
	
	end

	return first
	
end


function pickEntry(table)
	
	if table == nil then return false end

	return(table[math.random(# table)])
	
end



-- Annotations
-----------------------------------------------------------

function getAnnotation(key, polygon)

	for a in Annotations() do
		
		if a.polygon == polygon and a.text:find(key) then
			
			return a
			
		end
		
	end
	
	return false
	
end


function getAnnotations(key, polygon)

	polygon = polygon or nil
	
	local results = {}

	for a in Annotations() do
		
		if a.text:find(key) then
		
			if polygon then
				
				if a.polygon == polygon then
			
					table.insert(results, a)
					
				end
				
			else
			
				table.insert(results, a)
				
			end
			
		end
		
	end
	
	if # results == 0 then
	
		return false
		
	end
	
	return results
	
end


function getAnnotationContents(key, polygon, index)
	
	index = index or nil
	
	for a in Annotations() do
		
		if a.polygon == polygon and a.text:find(key) then
			
			if index then
				local results = filterCSVLine(a.text)
				return results[index]
			else
				return filterCSVLine(a.text)
			end
			
		end
		
	end
	
	return false
	
end


function findCommandAnnotations(commandPrefix)

	local results = {}

	for a in Annotations() do

		if string.find(a.text, "%b()") then
			
			local sP, fP = string.find(a.text,"%b()")
			local acPrefix = cleanInput(string.sub(a.text, 1, sP - 1))
			
			if acPrefix == commandPrefix then
				table.insert(results, a)
			end
			
		end
	
	end
	
	if # results >= 1 then
		return results
	else
		return false
	end
	
end


function processAnnotationCommand(annotation)

	local source = annotation.text

	local AC = {["prefix"] = nil, ["parameters"] = nil, ["polygon"] = annotation.polygon}
	
	if string.find(source, "%b()") then
		
		local sP, fP = string.find(source,"%b()")
		AC.prefix = string.sub(source, 1, sP - 1)
		AC.parameters = filterCSVLine(string.sub(source, sP + 1, fP - 1))
		
		return AC
		
	end
	
	return false
	
end


-- filterCSVLine takes a comma separated value string and transfers values into Lua table (as strings).
-- Use semicolons inside of a cell to delineate a cell subtable.

function filterCSVLine(source)

	local t = {}
	local ti = 1
	
	for chunk in source:gmatch("[^,]+") do
	
		if chunk:find(";") then -- Semicolon is subcell delimeter...
			
			local u = {}
			local ui = 1
			for crumb in chunk:gmatch("[^;]+") do
				u[ui] = cleanInput(crumb)
				ui = ui + 1
			end
			
			t[ti] = u
			
		else
			
			t[ti] = cleanInput(chunk)
			
		end
		
		ti = ti + 1
	
	end
	
	return t
	
end


-- Filters beginning, ending whitespace.
-- Interprets boolean conditions, as well as nil from a string.

function cleanInput(string)

	local s = string.find(string, "[^%s]")
	local f = string.find(string, "%s+$")
	
	if s == nil then
		s = 1
	end
	
	if f == nil then
		f = -1
	else
		f = f - 1
	end
	
	local cleaned = string.sub(string, s, f)

	if not string.find(cleaned, "%a") then
		cleaned = tonumber(cleaned)
	else
		if cleaned == "nil" then
			cleaned = nil
		elseif cleaned == "false" then
			cleaned = false
		elseif cleaned == "true" then
			cleaned = true
		end
	end
	
	return cleaned
	
end



-- Room Functions
-----------------------------------------------------------

RoomTemplates = {}

function gatherRoom(roomStemPolygon)

	local room = { roomStemPolygon }

	local filter = function(polygon)

		if polygon.type ~= "zone border" then
			return true
		end

		return false

	end

	gatherPolygonsRecursive(room, room[1], filter)

	return room

end


function applyRoomTemplates()
	
	local rooms = findCommandAnnotations("Template")
	
	if not rooms then return end
	
	for k, v in ipairs(rooms) do
		
		local room = processAnnotationCommand(v)
		local template = room.parameters[1]
		local roomPolygons = gatherRoom(room.polygon)
		
		RoomTemplates[template](roomPolygons)
		
	end
	
end



-- Timers
-----------------------------------------------------------

Timers = {}

TimerList = {}

function createTimer(period, repeating, action)

	local timer = Timers:new()
	
	timer.period = period - 1
	timer.repeating = repeating
	timer.action = action
	
	timer.count = period
	timer.status = "live"
	
	table.insert(TimerList, timer)
	
	return timer
	
end


function Timers:execute()

	self.action()

	if self.repeating then
	
		self:reset()
	
	else
		
		self.status = "dead"
		
	end
	
end


function Timers:reset()
	
	self.count = self.period
	
end


function Timers:kill()

	self.status = "dead"

end


function Timers:evaluate()

	if self.status == "dead" then
		return
	end

	if self.count <= 0 then
		self:execute()
		return
	end
	
	self.count = self.count - 1
	
end


function Timers:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end


function timersIdleUpkeep()

	local newSet = {}

	for i = 1, # TimerList, 1 do
		
		TimerList[i]:evaluate()
		if TimerList[i].status == "live" then
			table.insert(newSet, TimerList[i])
		end
		
	end

	TimerList = newSet
	
end