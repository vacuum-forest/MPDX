function initObjects()

	LadderTypes = {}
	LadderTypes["standard"] = {}
	LadderTypes["standard"].length = 0.5
	LadderTypes["standard"].object = "ladder"

	setupLadders()
	setupQRPlacards()

end

-- Ladders
-----------------------------------------------------------

function setupLadders()
	
	-- Ladder annotation syntax: "Ladder(type, length, z, facing)"
	
	local ladderQueue = findCommandAnnotations("Ladder")
	
	if not ladderQueue then return end
	
	for k, v in pairs(ladderQueue) do
		
		local data = processAnnotationCommand(v)
		
		local ladder = {}
		ladder.polygon = v.polygon
		ladder.x = v.x
		ladder.y = v.y
		
		if # data.parameters == 1 then
			
			ladder.id = data.parameters[1]
			
			if Level._ladders[ladder.id] then
				
				local defined = Level._ladders[ladder.id]
				ladder = mergeTableKeys(ladder, defined)

				installLadder(ladder)
				
			end
			
		else
	
			ladder.type = data.parameters[1]
			ladder.length = data.parameters[2]
			ladder.z = data.parameters[3]
			ladder.facing = data.parameters[4]
		
			installLadder(ladder)
			
		end
		
	end
	
end

Ladder = {}

Ladders = {}

function Ladder:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end


function installLadder(parameters)

	local ladder = Ladder:new()
	
	ladder.type = LadderTypes[parameters.type]
	ladder.length = parameters.length
	ladder.x = parameters.x
	ladder.y = parameters.y
	ladder.z = parameters.polygon.z + parameters.z
	ladder.facing = parameters.facing
	ladder.polygon = parameters.polygon
	ladder.media = parameters.polygon.media
	
	ladder.adjacent = {}
	
	ladder.climbAxis = {}
	ladder.climbAxis.x, ladder.climbAxis.y = radToCart(ladder.facing, 0.2)
	ladder.climbAxis.x = ladder.climbAxis.x + ladder.x
	ladder.climbAxis.y = ladder.climbAxis.y + ladder.y
	
	local segmentCount = math.floor(ladder.length / ladder.type.length)
	
	ladder.segments = {}
	
	local segment
	local position = { x = ladder.x, y = ladder.y, z = ladder.z, polygon = ladder.polygon, facing = ladder.facing }
	for i = 1, segmentCount, 1 do
		
		position.z = ((i - 1) * ladder.type.length) + ladder.z
		segment = createScenery(ladder.type.object, position)
		segment._owner = ladder
		table.insert(ladder.segments, segment)
		
	end
	
	local xo, yo = radToCart(ladder.facing + 180, 0.5)
	
	ladder.adjacent.x = ladder.x + xo
	ladder.adjacent.y = ladder.y + yo
	
	local ol = ladder.polygon:find_line_crossed_leaving(ladder.x, ladder.y, ladder.adjacent.x, ladder.adjacent.y)

	if ol.clockwise_polygon == ladder.polygon then
		ladder.adjacent.polygon = ol.ccw_polygon
	elseif ol.ccw_polygon == ladder.polygon then
		ladder.adjacent.polygon = ol.clockwise_polygon
	else
		ladder.adjacent.polygon = nil
	end
	
	ladder.top = ladder.z + (segmentCount * ladder.type.length)
	ladder.maxHeadroom = ladder.polygon.ceiling.z - 0.9
	
	table.insert(Ladders, ladder)
	
end


function Ladder:interaction()
	
	if Player.ladder.climbing == true then
		
		Player.ladder.climbing = false
		Kinetics.ladder("post")
	
		return
		
	end
	
	local face = normalizeAngle(self.facing + 180)
	
	local height
	if Player.me.z > self.top - Kinetics.heights.shoulders then
		height = self.top - Kinetics.heights.shoulders - 0.01
	elseif Player.me.z < self.z then
		height = self.z
	else
		height = Player.me.z
	end

	Kinetics.transit.after = function ()
		Player.ladder.id = self
		Player.ladder.z = Player.me.z
		Player.ladder.climbing = true
	end

	Kinetics.engageTransition(15, self.climbAxis.x, self.climbAxis.y, height, face)
	
end

-- QR Placards
-----------------------------------------------------------

function setupQRPlacards()

	local qrQueue = findCommandAnnotations("QR")

	if not qrQueue then return end

	for k, v in pairs(qrQueue) do

		local data = processAnnotationCommand(v)
	
		local qr = {}

		qr.x = v.x
		qr.y = v.y
		qr.polygon = v.polygon
		qr.facing = data.parameters[1]
		qr.content = data.parameters[2]
		
		placeQRPlacard(qr)
		
	end

end

QRPlacard = {}

QRPlacards = {}

function QRPlacard:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function placeQRPlacard(parameters)

	local qr = QRPlacard:new()
	
	qr.content = parameters.content
	qr.x = parameters.x
	qr.y = parameters.y
	qr.z = parameters.polygon.z + 0.6875
	qr.polygon = parameters.polygon
	qr.facing = parameters.facing

	qr.object = createScenery("qr placard", getPosition(qr))
	qr.object._owner = qr

end

function QRPlacard:interaction()

	Players.print(self.content)
	
end