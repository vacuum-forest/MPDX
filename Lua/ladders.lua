--[[	Ladders.lua (MPDX) by Ku-rin
		
		This script handles the interaction and mechanics of 3d scenery ladders.
	
]]

function initLadders()

	LadderTypes = {}
	
	LadderTypes["standard"] = {}
	LadderTypes["standard"].length = 0.5
	LadderTypes["standard"].object = "ladder 1"
	
	setupLadders()
	
end

Ladders = {}

function setupLadders()
	
	-- Ladder annotation syntax: "Ladder,[type],[length],[z],[facing]"

	local note = {}
	
	for a in Annotations() do
		
		if a.text:find("Ladder") then
			
			note = filterCSVLine(a.text)
			
			if note[1] == "Ladder" then
	
				local type = note[2]
				local length = tonumber(note[3])
				local z = tonumber(note[4])
				local facing = tonumber(note[5])
		 
				installLadder(type, length, a.x, a.y, z, facing, a.polygon)
		
			end
			
		end
		
	end
	
end

function installLadder(type, length, x, y, z, facing, polygon)

	local ladder = Ladders:new()
	
	ladder.type = LadderTypes[type]
	ladder.length = length
	ladder.x = x
	ladder.y = y
	ladder.z = polygon.z + z
	ladder.facing = facing
	ladder.polygon = polygon
	ladder.media = polygon.media
	
	ladder.adjacent = {}
	
	ladder.climbAxis = {}
	ladder.climbAxis.x, ladder.climbAxis.y = radToCart(facing, 0.2)
	ladder.climbAxis.x = ladder.climbAxis.x + x
	ladder.climbAxis.y = ladder.climbAxis.y + y
	
	local nSeg = math.floor(length / ladder.type.length)
	
	for i = 1, nSeg, 1 do
		
		local zObject = ((i - 1) * ladder.type.length) + ladder.z
	
		local ladderObject = Scenery.new(ladder.x, ladder.y, zObject, ladder.polygon, ladder.type.object)
		ladderObject.facing = ladder.facing
		ladderObject:position(ladder.x, ladder.y, zObject, ladder.polygon)
		ladderObject._parent = ladder
		
	end
	
	local ox, oy = radToCart(ladder.facing + 180, 0.5)
	
	ladder.adjacent.x = ladder.x + ox
	ladder.adjacent.y = ladder.y + oy
	
	local ol = ladder.polygon:find_line_crossed_leaving(ladder.x, ladder.y, ladder.adjacent.x, ladder.adjacent.y)
	
	ladder.adjacent.p = nil

	if ol.clockwise_polygon == ladder.polygon then
		ladder.adjacent.p = ol.ccw_polygon
	elseif ol.ccw_polygon == ladder.polygon then
		ladder.adjacent.p = ol.clockwise_polygon
	end
	
	ladder.top = ladder.z + (nSeg * ladder.type.length)
	ladder.maxHeadroom = ladder.polygon.ceiling.z - 0.9
	
end

function Ladders:interaction()
	
	Players.print("aL: " .. tostring(self.adjacent.p))
	
	if Player.ladder.climbing == true then
		
		Player.ladder.climbing = false
		motions.ladder("post")
	
		return
		
	end
	
	local face = normalizeAngle(self.facing + 180)
	
	local height
	if Player.me.z > self.top - motions.heights.shoulders then
		height = self.top - motions.heights.shoulders - 0.01
	elseif Player.me.z < self.z then
		height = self.z
	else
		height = Player.me.z
	end

	motions.transit.after = function ()	
		Player.ladder.id = self
		Player.ladder.z = Player.me.z
		Player.ladder.climbing = true
	end

	motions.engageTransition(15, self.climbAxis.x, self.climbAxis.y, height, face)
	
end

function Ladders:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end
