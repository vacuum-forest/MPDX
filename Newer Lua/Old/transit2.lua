--[[	Transit.lua (MPDX) by Ku-rin
	
]]

function initTransit()

	setupTransitPoints()
	
	if Continuity.state == "passed" then
	
		local next = findByID(Transit.starts, Players[0]._nextStart, 1)[1]
		next:go()
		
	end
	
end

	
function setupTransitPoints()

	-- From Doorways:
	for k, doorway in pairs(Doorways) do
		
		local start = {}
		
		if doorway.transit then
			
			start.id = doorway.id
			
			local from = doorway.transit.from
			local x, y = doorway.x, doorway.y
			local xd, yd
			
			if from.direction == "inside" then
				start.facing = (doorway.facing + 180) % 360
			else
				start.facing = doorway.facing
			end

			xd, yd = radToCart(start.facing, from.offset)
			start.x = x + xd
			start.y = y + yd
			
			local polygons = getPolygonAtLoc(start.x, start.y)
			
			if polygons then
				
				if # polygons == 1 then
					start.polygon = polygons[1]
				else
					for k, polygon in pairs(polygons) do
						if math.abs(polygon.z - doorway.z) < 0.25 then
							start.polygon = polygons[k]
							break
						end
					end
				end
				
				start.z = start.polygon.z
				
				createStartPoint(start)
				
			else
				
				assert(polygons, "Transit from-point of door " .. doorway.id .. " has invalid position.")
				
			end
			
		end
			
	end

	-- From Elevators
	
	-- From Annotations
	
end

Transit = {["starts"] = {}}

Start = {}

function createStartPoint(parameters)

	local start = Start:new()
	start.id = parameters.id
	start.x = parameters.x
	start.y = parameters.y
	start.z = parameters.z
	start.polygon = parameters.polygon
	start.facing = parameters.facing
	
	table.insert(Transit.starts, start)
	
end

function Start:new()

	o = {}
    setmetatable(o, self)
    self.__index = self
	return o

end

function Start:go()

	Player.me:position(self.x, self.y, self.z, self.polygon)
	Player.me.direction = self.facing
	
end

function Transit.go(destination)
		
	Player.me._nextStart = destination.start
	Player.me._previousYaw = Player.me.yaw
	Player.me:teleport_to_level(Levels[destination.level].index)
	
end