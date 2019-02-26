--[[	Transit.lua (MPDX) by Ku-rin
		
		This script handles player start-points, exits, interlevel transitions, and other elements of game persistence.
	
]]



function initTransit()

	setupStartPoints()
	
	if Player.me._intralevel_destination and not isSavedGame then
		
		for s = 1, # playerStarts, 1 do
			if playerStarts[s].id == Player.me._intralevel_destination then
				playerStarts[s]:go()
				break
			end
		end
		
	end
	
end

-- Start points are created with annotations on the map. Syntax: "Planum, id, height, facing"
-- As usual, do not leave spaces in your annotation.
	
function setupStartPoints()

	for a in Annotations() do
		if a.text:find("Planum") then
			local n = filterCSVLine(a.text)
			local id = tonumber(n[2])
			local z = tonumber(n[3])
			local facing = tonumber(n[4])
			installStartPoint(id, a.x, a.y, z, a.polygon, facing)
		end
	end

end

playerStarts = {}

StartPoints = {}

function installStartPoint(id, x, y, z, polygon, facing)

	local startPoint = StartPoints:new()
	startPoint.id = id
	startPoint.x = x
	startPoint.y = y
	startPoint.z = z + polygon.z
	startPoint.polygon = polygon
	startPoint.facing = facing
	
	table.insert(playerStarts, startPoint)
	
	return startPoint

end

function StartPoints:go()

	Player.me:position(self.x, self.y, self.z, self.polygon)
	Player.me.direction = self.facing
	
end

function StartPoints:new()

	o = {}
    setmetatable(o, self)
    self.__index = self
	return o

end

function levelTransition(target)

	Player.me._intralevel_destination = target.id
	
	--freeze level
	--fade
	
	Player.me:teleport_to_level(target.level)
	
end