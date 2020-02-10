--[[

	
]]

function initDoors() -- Triggers.init
	
	-- Door types --
	
	DoorTypes = {}
	
	DoorTypes.colliders = {}
	DoorTypes.colliders.radius = 32/1024
	DoorTypes.colliders.maxCount = 5
	DoorTypes.colliders.object = "door collision cylinder"

	DoorTypes["solid a"] = {}
	DoorTypes["solid a"].opens = "both"
	DoorTypes["solid a"].motion = "swing"
	DoorTypes["solid a"].halfWidth = 0.2375
	DoorTypes["solid a"].halfThick = 0.0315
	DoorTypes["solid a"].hingeAngle = 6.11944249	--Angle from hinge to door object center
	DoorTypes["solid a"].hingeRadius = 0.24019366	--Distance from hinge to door object center
	DoorTypes["solid a"].object = "door solid"
	DoorTypes["solid a"].handle = "handleset a"
	DoorTypes["solid a"].pair = true
	
	DoorTypes["solid b"] = {}
	DoorTypes["solid b"].opens = "both"
	DoorTypes["solid b"].motion = "swing"
	DoorTypes["solid b"].halfWidth = 0.2375
	DoorTypes["solid b"].halfThick = 0.0315
	DoorTypes["solid b"].hingeAngle = 6.11944249	
	DoorTypes["solid b"].hingeRadius = 0.24019366
	DoorTypes["solid b"].autoCloseDelay = 90
	DoorTypes["solid b"].object = "door solid"
	DoorTypes["solid b"].handle = "handleset b"
	DoorTypes["solid b"].pair = true
	
	DoorTypes["solid c"] = {}
	DoorTypes["solid c"].opens = "both"
	DoorTypes["solid c"].motion = "swing"
	DoorTypes["solid c"].halfWidth = 0.2375
	DoorTypes["solid c"].halfThick = 0.0315
	DoorTypes["solid c"].hingeAngle = 6.11944249	
	DoorTypes["solid c"].hingeRadius = 0.24019366
	DoorTypes["solid c"].autoCloseDelay = 90
	DoorTypes["solid c"].object = "door solid"
	DoorTypes["solid c"].handle = "handleset c"
	DoorTypes["solid c"].pair = true
	
	DoorTypes["solid d"] = {}
	DoorTypes["solid d"].opens = "both"
	DoorTypes["solid d"].motion = "swing"
	DoorTypes["solid d"].halfWidth = 0.2375
	DoorTypes["solid d"].halfThick = 0.0315
	DoorTypes["solid d"].hingeAngle = 6.11944249	
	DoorTypes["solid d"].hingeRadius = 0.24019366
	DoorTypes["solid d"].autoCloseDelay = 60
	DoorTypes["solid d"].object = "door solid"
	DoorTypes["solid d"].handle = "handleset d"
	DoorTypes["solid d"].pair = true
	
	DoorTypes["glass a"] = {}
	DoorTypes["glass a"].opens = "both"
	DoorTypes["glass a"].motion = "swing"
	DoorTypes["glass a"].halfWidth = 0.2375
	DoorTypes["glass a"].halfThick = 0.0315
	DoorTypes["glass a"].hingeAngle = 6.11944249
	DoorTypes["glass a"].hingeRadius = 0.24019366	
	DoorTypes["glass a"].object = "door glass"
	DoorTypes["glass a"].handle = "handleset a"
	DoorTypes["glass a"].pair = true
	
	DoorTypes["glass b"] = {}
	DoorTypes["glass b"].opens = "both"
	DoorTypes["glass b"].motion = "swing"
	DoorTypes["glass b"].halfWidth = 0.2375
	DoorTypes["glass b"].halfThick = 0.0315
	DoorTypes["glass b"].hingeAngle = 6.11944249	
	DoorTypes["glass b"].hingeRadius = 0.24019366
	DoorTypes["glass b"].autoCloseDelay = 90
	DoorTypes["glass b"].object = "door glass"
	DoorTypes["glass b"].handle = "handleset b"
	DoorTypes["glass b"].pair = true
	
	DoorTypes["glass c"] = {}
	DoorTypes["glass c"].opens = "both"
	DoorTypes["glass c"].motion = "swing"
	DoorTypes["glass c"].halfWidth = 0.2375
	DoorTypes["glass c"].halfThick = 0.0315
	DoorTypes["glass c"].hingeAngle = 6.11944249	
	DoorTypes["glass c"].hingeRadius = 0.24019366
	DoorTypes["glass c"].autoCloseDelay = 90
	DoorTypes["glass c"].object = "door glass"
	DoorTypes["glass c"].handle = "handleset c"
	DoorTypes["glass c"].pair = true
	
	DoorTypes["glass d"] = {}
	DoorTypes["glass d"].opens = "both"
	DoorTypes["glass d"].motion = "swing"
	DoorTypes["glass d"].halfWidth = 0.2375
	DoorTypes["glass d"].halfThick = 0.0315
	DoorTypes["glass d"].hingeAngle = 6.11944249	
	DoorTypes["glass d"].hingeRadius = 0.24019366
	DoorTypes["glass d"].autoCloseDelay = 60
	DoorTypes["glass d"].object = "door glass"
	DoorTypes["glass d"].handle = "handleset d"
	DoorTypes["glass d"].pair = true
	
	DoorTypes["automatic"] = {}
	DoorTypes["automatic"].opens = "none"
	DoorTypes["automatic"].motion = "slide"
	DoorTypes["automatic"].halfWidth = 0.233125
	DoorTypes["automatic"].halfThick = 0.0315
	DoorTypes["automatic"].hingeAngle = nil	
	DoorTypes["automatic"].hingeRadius = nil
	DoorTypes["automatic"].autoCloseDelay = 90
	DoorTypes["automatic"].object = "door automatic"
	DoorTypes["automatic"].pair = false
	DoorTypes["automatic"].slideDistance = 0.375
	
	DoorTypes["elevator"] = {}
	DoorTypes["elevator"].opens = "both"
	DoorTypes["elevator"].motion = "slide"
	DoorTypes["elevator"].halfWidth = 0.25
	DoorTypes["elevator"].halfThick = 0.0575
	DoorTypes["elevator"].hingeAngle = nil
	DoorTypes["elevator"].hingeRadius = nil
	DoorTypes["elevator"].autoCloseDelay = 90
	DoorTypes["elevator"].object = "door elevator"
	DoorTypes["elevator"].pair = false
	DoorTypes["elevator"].slideDistance = 0.5
	
	DoorTypes["toilet"] = {}
	DoorTypes["toilet"].opens = "both"
	DoorTypes["toilet"].motion = "swing"
	DoorTypes["toilet"].halfWidth = 0.22
	DoorTypes["toilet"].halfThick = 0.05
	DoorTypes["toilet"].hingeAngle = 0
	DoorTypes["toilet"].hingeRadius = 0.21625
	DoorTypes["toilet"].object = "door toilet"
	DoorTypes["toilet"].handle = nil
	DoorTypes["toilet"].pair = false
	
	
	-- Doorway types --
	
	DoorwayTypes = {}
	
	DoorwayTypes["solid single a"] = {}
	DoorwayTypes["solid single a"].frame = "doorframe single"
	DoorwayTypes["solid single a"].doors = {
	{type = "solid a", orientation = "left"}
	}
	
	DoorwayTypes["solid single b"] = {}
	DoorwayTypes["solid single b"].frame = "doorframe single"
	DoorwayTypes["solid single b"].doors = {
	{type = "solid b", orientation = "left"}
	}
	
	DoorwayTypes["solid single c"] = {}
	DoorwayTypes["solid single c"].frame = "doorframe single"
	DoorwayTypes["solid single c"].doors = {
	{type = "solid c", orientation = "left"}
	}
	
	DoorwayTypes["solid single d"] = {}
	DoorwayTypes["solid single d"].frame = "doorframe single"
	DoorwayTypes["solid single d"].doors = {
	{type = "solid d", orientation = "left"}
	}
	
	DoorwayTypes["solid single d reverse"] = {}
	DoorwayTypes["solid single d reverse"].frame = "doorframe single"
	DoorwayTypes["solid single d reverse"].doors = {
	{type = "solid d", orientation = "right"}
	}
	
	DoorwayTypes["glass single a"] = {}
	DoorwayTypes["glass single a"].frame = "doorframe single"
	DoorwayTypes["glass single a"].doors = {
	{type = "glass a", orientation = "left"}
	}
	
	DoorwayTypes["glass single b"] = {}
	DoorwayTypes["glass single b"].frame = "doorframe single"
	DoorwayTypes["glass single b"].doors = {
	{type = "glass b", orientation = "left"}
	}
	
	DoorwayTypes["glass single c"] = {}
	DoorwayTypes["glass single c"].frame = "doorframe single"
	DoorwayTypes["glass single c"].doors = {
	{type = "glass c", orientation = "left"}
	}
	
	DoorwayTypes["glass single d"] = {}
	DoorwayTypes["glass single d"].frame = "doorframe single"
	DoorwayTypes["glass single d"].doors = {
	{type = "glass d", orientation = "left"}
	}
	
	DoorwayTypes["glass single d reverse"] = {}
	DoorwayTypes["glass single d reverse"].frame = "doorframe single"
	DoorwayTypes["glass single d reverse"].doors = {
	{type = "glass d", orientation = "right"}
	}
	
	DoorwayTypes["solid double a"] = {}
	DoorwayTypes["solid double a"].frame = "doorframe double"
	DoorwayTypes["solid double a"].doors = {
	{type = "solid a", orientation = "left"},
	{type = "solid a", orientation = "right"}
	}
	
	DoorwayTypes["solid double b"] = {}
	DoorwayTypes["solid double b"].frame = "doorframe double"
	DoorwayTypes["solid double b"].doors = {
	{type = "solid b", orientation = "left"},
	{type = "solid b", orientation = "right"}
	}
	
	DoorwayTypes["solid double c"] = {}
	DoorwayTypes["solid double c"].frame = "doorframe double"
	DoorwayTypes["solid double c"].doors = {
	{type = "solid c", orientation = "left"},
	{type = "solid c", orientation = "right"}
	}
	
	DoorwayTypes["solid double d"] = {}
	DoorwayTypes["solid double d"].frame = "doorframe double"
	DoorwayTypes["solid double d"].doors = {
	{type = "solid d", orientation = "left"},
	{type = "solid d", orientation = "right"}
	}
	
	DoorwayTypes["glass double a"] = {}
	DoorwayTypes["glass double a"].frame = "doorframe double"
	DoorwayTypes["glass double a"].doors = {
	{type = "glass a", orientation = "left"},
	{type = "glass a", orientation = "right"}
	}
	
	DoorwayTypes["glass double b"] = {}
	DoorwayTypes["glass double b"].frame = "doorframe double"
	DoorwayTypes["glass double b"].doors = {
	{type = "glass b", orientation = "left"},
	{type = "glass b", orientation = "right"}
	}
	
	DoorwayTypes["glass double c"] = {}
	DoorwayTypes["glass double c"].frame = "doorframe double"
	DoorwayTypes["glass double c"].doors = {
	{type = "glass c", orientation = "left"},
	{type = "glass c", orientation = "right"}
	}
	
	DoorwayTypes["glass double d"] = {}
	DoorwayTypes["glass double d"].frame = "doorframe double"
	DoorwayTypes["glass double d"].doors = {
	{type = "glass d", orientation = "left"},
	{type = "glass d", orientation = "right"}
	}
	
	DoorwayTypes["automatic"] = {}
	DoorwayTypes["automatic"].autoOpen = true
	DoorwayTypes["automatic"].colliders = {0.636, 0.233}
	DoorwayTypes["automatic"].frame = "doorframe automatic"
	DoorwayTypes["automatic"].doors = {
		{type = "automatic", orientation = "left"},
		{type = "automatic", orientation = "right"}
	}
	
	DoorwayTypes["elevator"] = {}
	DoorwayTypes["elevator"].mirror = true
	DoorwayTypes["elevator"].doors = {
		{type = "elevator", orientation = "left"},
		{type = "elevator", orientation = "right"}
	}
	
	DoorwayTypes["toilet"] = {}
	DoorwayTypes["toilet"].fOffset = 0.02125
	DoorwayTypes["toilet"].zOffset = 0.0625
	DoorwayTypes["toilet"].frame = "doorframe toilet"
	DoorwayTypes["toilet"].doors = {
		{type = "toilet", orientation = "left"}
	}
	
	setupDoors()
	
end

function setupDoors()
	
	-- Door annotation syntax: "Door(type, facing, enable, lock, keys, id)"

	local doorwayQueue = findCommandAnnotations("Door")
	
	if not doorwayQueue then return end
	
	for k, v in pairs(doorwayQueue) do
	
		local data = processAnnotationCommand(v)
		
		local doorway = {}
		doorway.polygon = v.polygon
		
		if # data.parameters == 1 then
			
			doorway.id = data.parameters[1]
			
			if Level._doorways[Level.index][doorway.id] then
				local defined = Level._doorways[Level.index][doorway.id]
				doorway = mergeTableKeys(doorway, defined)
			
				installDoorway(doorway)
			end
			
		else
			
			doorway.type = data.parameters[1]
			doorway.facing = data.parameters[2]
			
			-- Optional
			doorway.enable = true
			doorway.lock = "none"
			doorway.keys = nil
			doorway.id = nil
			
			if data.parameters[3] then doorway.enable = data.parameters[3] end
			if data.parameters[4] then doorway.lock = data.parameters[4] end
			if data.parameters[5] then doorway.keys = data.parameters[5] end
			if data.parameters[6] then doorway.id = data.parameters[6] end
		
			installDoorway(doorway)
			
		end
		
	end

end



-- Doorways
-----------------------------------------------------------

Doorway = {} 	-- This is the definition of a Door object.

Doorways = {} 	-- This table contains all doors. (Try not to confuse yourself.)


function Doorway:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end


function installDoorway(parameters)

	local doorway = Doorway:new()
	
	doorway.id = parameters.id
	doorway.type = DoorwayTypes[parameters.type]

	doorway.x = parameters.polygon.x
	doorway.y = parameters.polygon.y
	doorway.z = parameters.polygon.z
	doorway.facing = parameters.facing
	doorway.polygon = parameters.polygon
	
	doorway.enable = parameters.enable
	doorway.lock = parameters.lock
	doorway.keys = parameters.keys
	
	doorway.transit = parameters.transit
	doorway.placard = parameters.placard
	
	if doorway.type.zOffset then
		doorway.z = doorway.z + doorway.type.zOffset
	end
	
	if doorway.type.fOffset then
		local xo, yo = radToCart(doorway.facing, doorway.type.fOffset * -1)
		doorway.x = doorway.x + xo
		doorway.y = doorway.y + yo
	end
	
	-- Place Frame Object

	if doorway.type.frame then
		doorway.frame = createScenery(doorway.type.frame, getPosition(doorway))
		doorway.frame._owner = doorway
	end
	
	-- Place Door(s)
	
	doorway.doors = {}
	
	local door
	for i = 1, # doorway.type.doors, 1 do
		
		local queued = doorway.type.doors[i]
		local parameters = {}
		parameters.type = queued.type
		if queued.orientation then
			parameters.orientation = queued.orientation
		end
		parameters.owner = doorway
		
		door = installDoor(parameters)
		
		table.insert(doorway.doors, door)
		
	end
	
	-- Elevators
	
	local elevatorID = getAnnotationContents("Elevator", doorway.polygon, 2)
	if elevatorID then
		local elevator = findByID(Elevators, elevatorID)
		elevator.door = doorway
		elevator.polygon = doorway.polygon
		doorway.elevator = elevator
	end

	-- Automatic Opener
	
	if doorway.type.autoOpen then
		local opener = Monsters.new(doorway.x, doorway.y, doorway.z + 0.9, doorway.polygon, MonsterTypes["door daemon"])
		opener._owner = doorway
	end
	
	-- Optional Extra Colliders
	
	if doorway.type.colliders then
		
		local cOffset = doorway.type.colliders[1]
		local cRadius = doorway.type.colliders[2]
		local xcc, ycc, acc
		
		for i = -1, 1, 2 do
			
			acc = doorway.facing + (90 * i)
			xcc, ycc = radToCart(acc, cOffset)
			xcc = xcc + doorway.x
			ycc = ycc + doorway.y
			
			local numCol = math.floor(cRadius / DoorTypes.colliders.radius)
	
			if numCol % 2 == 0 then
				numCol = numCol - 1 
			end
	
			numCol = math.min(numCol, 5)
	
			local colliderSpacing = cRadius * 2 / numCol
	
			local count = math.floor(numCol / 2)
	
			for j = -count, count, 1 do
				local xc, yc = radToCart(acc, colliderSpacing * j)
				local col = Scenery.new(xcc + xc, ycc + yc, doorway.z, doorway.polygon, DoorTypes.colliders.object)
				col:position(xcc + xc, ycc + yc, doorway.z, doorway.polygon)
			end
			
		end
		
	end

	-- Optional QR Placard

	if doorway.placard then

		local placard = doorway.placard
		local placement = placard.placement
	
		local hOffset = 0.125/2
		if string.find(doorway.type.frame, "single") then
			hOffset = hOffset + 0.25
		elseif  string.find(doorway.type.frame, "double") then
			hOffset = hOffset + 0.5
		elseif string.find(doorway.type.frame, "automatic") then
			hOffset = hOffset + 0.875
		end
		
		local direction
		if placement == "outside" then
			direction = doorway.facing
			placement = "inside"
		else
			direction = (doorway.facing + 180) % 360
			placement = "outside"
		end
		
		local tangent
		if placard.orientation == "left" then
			tangent = (direction + 90) % 360
		else
			tangent = (direction - 90) % 360
		end
		
		local xl, yl = offsetRadial(doorway.x, doorway.y, direction, 1)
		local frameLine = doorway.polygon:find_line_crossed_leaving(doorway.x, doorway.y, xl, yl)
		xl, yl = getIntersection(doorway, {["x"] = xl, ["y"] = yl}, frameLine.endpoints[0], frameLine.endpoints[1])
		xl, yl = offsetRadial(xl, yl, direction, 0.001)
		xl, yl = offsetRadial(xl, yl, tangent, hOffset)
		
		local qpoly = getPolygonAtLoc(xl, yl, doorway.z)
		
		local qr = {["x"] = xl, ["y"] = yl, ["polygon"] = qpoly, ["facing"] = direction, ["content"] = placard.text}
		
		placeQRPlacard(qr)

	end
	
	doorway.polygon._doorway = doorway
	table.insert(Doorways, doorway)

end


function Doorway:open() -- Trigger a doorway to open its doors simultaneously.

	if not self.enable then
		return
	end

	for i = 1, # self.doors, 1 do
	
		if self.doors[i].state == "closed" then
			self.doors[i]:start()
		end
		
	end
	
end


function Doorway:close() -- Trigger a doorway to close its doors simultaneously.

	if not self.enable then
		return
	end

	for i = 1, # self.doors, 1 do
	
		if self.doors[i].state == "open" then
			self.doors[i]:start()
		end
		
	end
	
end


function Doorway:setEnable(command)
	
	if command == "toggle" then
		self.enable = self.enable ~= true
	else
		self.enable = command == true
	end
	
	for i = 1, # self.doors, 1 do
		self.doors[i].enable = self.enable
	end
	
end


function Doorway:switchLock(timer) -- Unlock or lock a door, temporarily or permanently.
	
	if self.lock ~= "none" then
		self.lastLock = self.lock
		self.lock = "none"
		
		for i = 1, # self.doors, 1 do
			self.doors[i].lock = self.lock
		end
	
		if timer then 
			
			local resetLock = function() 
				self.lock = self.lastLock
				self.lastLock = nil
				self.lockTimer = nil
				for i = 1, # self.doors, 1 do
					self.doors[i].lock = self.lock
				end
			end
		
			self.lockTimer = createTimer(timer, false, resetLock)
			
		end
	
	elseif self.lastLock then
		
		self.lock = self.lastLock
		self.lastLock = nil
		for i = 1, # self.doors, 1 do
			self.doors[i].lock = self.lock
		end
	
	end
	
end



-- Doors
-----------------------------------------------------------

Door = {}
Door.minimumAngularDeflection = 1			-- Mimimum angular velocity in degrees/tick
Door.maximumAngularDeflection = 4			-- Maximum angular velocity in degrees/tick
Door.minimumLinearDisplacement = 0.0075		-- Minimum lateral velocity in WU/tick
Door.maximumLinearDisplacement = 0.025		-- Maximum lateral velocity in WU/tick

Doors = {} 


function Door:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end


function installDoor(parameters)

	local door = Door:new()
	
	door.type = DoorTypes[parameters.type]
	door.owner = parameters.owner
	door.enable = door.owner.enable
	door.lock = door.owner.lock
	door.keys = door.owner.keys
	door.orientation = parameters.orientation
	
	
	-- Establish Position
	
	door.x = door.owner.x
	door.y = door.owner.y
	door.z = door.owner.z
	door.facing = door.owner.facing
	door.polygon = door.owner.polygon
	
	
	-- Set Initial State
	
	door.state = "closed"	-- (closed, open, closing, opening)
	
	
	-- Copy additional parameters from DoorType
	
	door.opens = door.type.opens -- (inside, outside, both, none)
	door.motion = door.type.motion -- (swing, slide)
	door.halfWidth = door.type.halfWidth -- ([WU])
	door.halfThick = door.type.halfThick -- ([WU])
	door.hingeAngle = door.type.hingeAngle or nil -- ([deg])
	door.hingeRadius = door.type.hingeRadius or nil -- ([WU])
	
	
	-- Configure Auto-closing Timer Settings
	
	if not parameters.autoClose then
	
		if door.type.autoCloseDelay then
			door.closeTimer = 0
			door.autoCloseDelay = door.type.autoCloseDelay
		end
		
	else
		
		door.closeTimer = 0
		door.autoCloseDelay = parameters.autoClose
		
	end
	
	
	-- Offset Double Door Positions
	
	if # door.owner.type.doors == 2 then
		
		local dt
		if door.orientation == "right" then
			dt = door.facing + 90
		else
			dt = door.facing - 90
		end
	
		local xs, ys = radToCart(dt, door.halfWidth)
		door.x = door.x + xs
		door.y = door.y + ys
		
	end
	
	
	-- Create Door Object
	
	local scenery
	
	if door.type.pair then
		if door.orientation == "right" then
			scenery = door.type.object .. " r"
		else
			scenery = door.type.object .. " l"
		end
	else
		scenery = door.type.object
	end
	
	door.object = createScenery(scenery, getPosition(door))
	door.object._owner = door
	
	
	-- Create Handle Object
	
	if door.type.handle then
		
		if door.orientation == "right" then
			scenery = door.type.handle .. " r"
		else
			scenery = door.type.handle .. " l"
		end
		
		door.handle = createScenery(scenery, getPosition(door))
		door.handle._owner = door
		
	end
	
	
	-- Create Door Colliders
	
	door.colliders = {}
	
	local colliderCount = math.floor(door.halfWidth / DoorTypes.colliders.radius) -- Number of colliders to place
	
	if colliderCount % 2 == 0 then -- Keep odd number of colliders per door
		colliderCount = colliderCount - 1 
	end
	
	colliderCount = math.min(colliderCount, DoorTypes.colliders.maxCount) -- Limit maximum number of colliders (if so ordained)
	
	door.colliderSpacing = math.min((door.halfWidth - DoorTypes.colliders.radius / 2) * 2, 1) / colliderCount -- Distance between colliders
	
	local xco, yco	-- Collider Offset
	if door.motion == "swing" then
		xco, yco = radToCart(door.facing, door.halfThick / 2)
	else
		xco, yco = radToCart(door.facing - 180, door.halfThick / 2)
	end
	
	local count = math.floor(colliderCount / 2)
	for i = -count, count, 1 do
		local xc, yc = radToCart(door.facing - 90, door.colliderSpacing * i)
		local collider = Scenery.new(door.x, door.y, door.z, door.polygon, DoorTypes.colliders.object)
		collider:position(door.x + xc + xco, door.y + yc + yco, door.z, door.polygon)
		collider._owner = door
		table.insert(door.colliders, collider)
	end
	
	
	-- Establish motion parameters
	
	if door.type.motion == "swing" then -- Set up hinge position, angles for swingers:
		
		door.closedAngle = door.facing
		
		local dt
		if door.orientation == "right" then
			dt = door.facing + 90 - door.hingeAngle
			door.baseOpenAngle = door.facing + 90
			door.openAngle = door.baseOpenAngle
		else
			dt = door.facing - 90 + door.hingeAngle
			door.baseOpenAngle = door.facing - 90
			door.openAngle = door.baseOpenAngle
		end
		
		local xh, yh = radToCart(dt, door.hingeRadius)
		door.hingeX = door.x + xh
		door.hingeY = door.y + yh
		
	elseif door.motion == "slide" then -- Set up open, closed positions for sliders:
		
		local openDistance
		if door.type.slideDistance then
			openDistance = door.type.slideDistance
		else
			openDistance = door.halfWidth * 2
		end
		
		door.xClosed = door.x
		door.yClosed = door.y
		
		local xo, yo
		if door.orientation == "right" then
			xo, yo = radToCart(door.facing + 90, openDistance)
		else
			xo, yo = radToCart(door.facing - 90, openDistance)
		end
		
		door.xOpen = door.x + xo
		door.yOpen = door.y + yo
		
	else -- Something went horribly wrong!
		
		return nil
		
	end
	
	
	door:updateAllObjectPositions()
	table.insert(Doors, door)
	return door
	
end


function Door:updateAllObjectPositions()

	-- Ensure proper polygon is assigned:
	for p in Polygons() do
		if p:contains(self.x, self.y) then
			if self.z <= p.ceiling.z and self.z >= p.floor.z then
				self.polygon = p
				break
			end
		end
	end

	-- Move the door object:
	self.object:position(self.x, self.y, self.z, self.polygon)
	if self.owner.type.mirror and self.orientation == "right" then
		self.object.facing = self.facing + 180
	else
		self.object.facing = self.facing
	end
	
	-- Move the handle object:
	if self.handle then
		self.handle:position(self.x, self.y, self.z, self.polygon)
		self.handle.facing = self.facing
	end
	
	-- Move the collider objects:
	local xco, yco
	if self.motion == "swing" then
		xco, yco = radToCart(self.facing, self.halfThick / 2)
	else
		xco, yco = radToCart(self.facing - 180, self.halfThick / 2)
	end
	
	local count = # self.colliders
	count = math.floor(count / 2)

	local j = 1
	for i = -count, count, 1 do
		local xc, yc = radToCart(self.facing - 90, self.colliderSpacing * i)
		self.colliders[j]:position(self.x + xc + xco, self.y + yc + yco, self.z, self.polygon)
		j = j + 1
	end
	
end


function Door:getDirection(angle)
	
	local dir = 1
	
	if self.state == "opening" then
		if self.orientation == "left" then
			dir = -1
		end
	elseif self.state == "closing" then
		if self.orientation == "right" then
			dir = -1
		end
	else
		dir = 0
	end

	return dir

end


function Door:getAngularDeflection()

	local alpha
	local angle = 0
	local sweep = math.abs(self.openAngle - self.closedAngle) * 2

	if self.state == "opening" then
		alpha = math.abs(self.openAngle - self.facing)
	elseif self.state == "closing" then
		alpha = math.abs(self.closedAngle - self.facing)
	else
		return angle -- Something is horribly wrong!
	end
	
	if alpha < Door.minimumAngularDeflection then
		return alpha
	end
	
	angle = math.max(Door.maximumAngularDeflection * math.sin(math.pi * (alpha / sweep)), Door.minimumAngularDeflection)
	
	return angle
	
end


function Door:getLinearDeflection()
	
	local xDelta, yDelta
	local xSweep = math.abs(self.xOpen - self.xClosed)	-- Total Deflections
	local ySweep = math.abs(self.yOpen - self.yClosed)
	
	if self.state == "opening" then
		xDelta = math.abs(self.xOpen - self.x)
		yDelta = math.abs(self.yOpen - self.y)
	elseif self.state == "closing" then
		xDelta = math.abs(self.xClosed - self.x)
		yDelta = math.abs(self.yClosed - self.y)
	else
		return
	end
	
	-- Motion Speed Easing
	local defX, defY
	if xDelta >= Door.minimumLinearDisplacement then
		defX = math.max(Door.maximumLinearDisplacement * math.sin(math.pi * xDelta / xSweep), Door.minimumLinearDisplacement)
	else
		defX = xDelta
	end	
	
	if yDelta >= Door.minimumLinearDisplacement then
		defY = math.max(Door.maximumLinearDisplacement * math.sin(math.pi * yDelta / ySweep), Door.minimumLinearDisplacement)
	else
		defY = yDelta
	end	

	return defX, defY
	
end


function Door:move()

	local direction = self:getDirection()

	-- Swinging doors
	if self.motion == "swing" then
		
		local angle = self:getAngularDeflection()
		angle = angle * direction
		self.facing = self.facing + angle
		
		--Start
		local dx, dy, dt
		
		if self.orientation == "left" then
			dt = self.facing + 90 + self.hingeAngle
		else
			dt = self.facing - 90 - self.hingeAngle
		end
		
		dx, dy = radToCart(dt, self.hingeRadius)
		
		--End
		
		self.x = dx + self.hingeX
		self.y = dy + self.hingeY
		
		-- Stop door if end reached
		if self.state == "opening" then
			if math.abs(self.facing - self.openAngle) < 0.01 then
				self:stop()
			end
		elseif self.state == "closing" then
			if math.abs(self.facing - self.closedAngle) < 0.01 then
				self:stop()
			end
		else
			self:stop()
		end
		
	-- Sliding doors
	else
	
		if (tonumber(self.facing) >= 90) and (tonumber(self.facing) < 270) then
			direction = direction * -1
		end
	
		local dx, dy = self:getLinearDeflection()
		
		self.x = dx * direction + self.x
		self.y = dy * direction + self.y
		

		if dx == 0 and dy == 0 then
			self:stop()
		end
	
	end
	
	self:updateAllObjectPositions()

end


function Door:start()
		
	if self.state == "opening" or self.state == "closing" then
		
		return
		
	else
		
		if self.state == "closed" then
			
			--Randomly vary open angle by up to 5°
			if self.motion == "swing" then
				if self.orientation == "right" then
					self.openAngle = self.baseOpenAngle + Game.global_random(5)
				else
					self.openAngle = self.baseOpenAngle - Game.global_random(5)
				end
			end
			
			if self.motion == "slide" and Players[0].polygon == self.polygon then
				Players[0]:print("You probably shouldn't shut the door on yourself, that would hurt.")
				return
			end
			
			self.state = "opening"
			
		elseif self.state == "open" then
			
			local obstructed = false
			
			for m in self.polygon:monsters() do
				
				if m.polygon == self.polygon and m.type ~= "door daemon" then
					
					obstructed = true
					break
					
				end
				
			end
			
			if obstructed then
			
				if self.motion == "slide" then
			
					if self.autoCloseDelay then
						self.closeTimer = self.autoCloseDelay / 2
						self.polygon:play_sound("cant toggle switch")
						return
					else
						if Players[0].polygon == self.polygon then
							Players[0]:print("You probably shouldn't shut the door on yourself, that would hurt.")
							return
						else
							Players[0]:print("You can't close the door, there's something in the way.")
							return
						end
					end
					
				end
			
			end
			
			self.state = "closing"
			
		end
		
	end
	
end


function Door:stop()

	if self.state == "open" or self.state == "closed" then
		return
	else
		if self.state == "opening" then
			self.state = "open"
			if self.autoCloseDelay then					-- Reset the timer to close the doors if needed
				self.closeTimer = self.autoCloseDelay
			end
		elseif self.state == "closing" then
			self.state = "closed"
		end
	end
	
	--Update polygon type to restrict/allow monster pathing through a door
	if self.state == "open" then
		self.owner.polygon.type = PolygonTypes["normal"]
	elseif self.state == "closed" then
		self.owner.polygon.type = PolygonTypes["monster impassable"]
	end
	
end


function Door:checkDoorSide(knocker)

	local bearing = math.floor(getBearing(self, knocker) - self.facing)
	if bearing < 0 then
		bearing = bearing + 360
	end
	local side = (bearing + 90) % 360
	if side <= 180 then
		return "outside"
	else
		return "inside"
	end
	
end


function Door:canUnlock()
	
	if not self.keys then
		return false
	else
		
	end
	
	for i = 1, # self.keys, 1 do
		if playerHasKey(self.keys[i]) then
			return true
		end
	end
	
	return false
	
end


function Door:setState(state)

	if self.type.motion == "swing" then
		
		local angle
		
		if state == "open" then
			
			angle = self.openAngle
			
		else
			
			angle = self.closedAngle
			
		end

		self.facing = angle
		
		--Start
		local dx, dy, dt
		
		if self.orientation == "left" then
			dt = self.facing + 90 + self.hingeAngle
		else
			dt = self.facing - 90 - self.hingeAngle
		end
		
		dx, dy = radToCart(dt, self.hingeRadius)
		--End
		
		self.x = dx + self.hingeX
		self.y = dy + self.hingeY
		
		-- Pass updates to scenery object
		self.object.facing = self.facing
		self.object:position(self.x, self.y, self.z, self.polygon)
		
	else
		
		local x, y
		
		if state == "open" then
			x = self.xOpen
			y = self.yOpen
		else
			x = self.xClosed
			y = self.yClosed
		end
		
		self.object:position(self.x, self.y, self.z, self.polygon)
		
	end

	self.state = state

	self:updateColliders()
	
	-- Update door object polygon for superior rendering!
	for p in Polygons() do
		if p:contains(self.x, self.y) then
			if self.z < p.ceiling.z and self.z >= p.floor.z then
				self.polygon = p
				self.object:position(self.x, self.y, self.z, self.polygon)
				break
			end
		end
	end
	
	--Update polygon type to restrict/allow monster pathing through a door
	if self.state == "open" then
		self.owner.polygon.type = PolygonTypes["normal"]
	elseif self.state == "closed" then
		self.owner.polygon.type = PolygonTypes["monster impassable"]
	end
	
end


function Door:interaction()

	-- Door does not activate with player interaction:
	if self.type.opens == "none" then
		return
	end
	
	-- Door is disabled:
	if not self.enable then
		Players[0]:print("It doesn't seem to want to move at all.")
		self.polygon:play_sound(195)
		return
	end
	
	-- Door leads to another level:
	if self.owner.transit then
		
		if self.lock ~= "none" then
			
			if self.lock == "both" or self:checkDoorSide(Players[0]) == self.lock then
				if not self:canUnlock() then
					Players[0]:print("It's locked.")
					return
				end
			end
		
		end
		Players.print(self.owner.transit.to.level)
		Transit.go(self.owner.transit.to)
		return
		
	end
	
	-- Door is already moving:
	if self.state == "opening" or self.state == "closing" then
		
		return
		
	elseif self.state == "closed" then
		
		if self.type.opens == "both" then
			
			-- Don't worry!
			
		else
			
			if self:checkDoorSide(Players[0]) ~= self.type.opens then
				Players[0]:print("It doesn't seem to open from this side.")
				return
			end
			
		end
		
		if self.lock ~= "none" then
			
			if self.lock == "both" or self:checkDoorSide(Players[0]) == self.lock then
				if not self:canUnlock() then
					Players[0]:print("It's locked.")
					return
				end
			end
		
		end
	
	elseif self.state == "open" then
		
		-- Don't worry!
		
	else
		
		return
		
	end
	
	self:start()
	
end



-- Trigger Functions
-----------------------------------------------------------

function doorsIdleUpkeep() -- Triggers.idle

	for n = 1, # Doors, 1 do

		if Doors[n].state == "opening" or Doors[n].state == "closing" then
			Doors[n]:move()
		elseif Doors[n].state == "open" then
			if Doors[n].autoCloseDelay then
				if Doors[n].closeTimer > 0 then
					Doors[n].closeTimer = Doors[n].closeTimer - 1
				else
					Doors[n]:start()
				end
			end
		end
		
	end
	
end


function doorsMDamagedUpkeep(monster, aggressor_monster, damage_type) -- Triggers.monster_damaged
	
	local door = aggressor_monster._owner.doors[1]
	if damage_type == "sensor" and aggressor_monster.type == "door daemon" then
		if door.lock ~= door:checkDoorSide(monster) then
			aggressor_monster._owner:open()
		end
	end

end


function doorsPDamagedUpkeep(victim, aggressor_monster, damage_type) -- Triggers.player_damaged
	
	local door = aggressor_monster._owner.doors[1]
	if damage_type == "sensor" and aggressor_monster.type == "door daemon" then
		if door.lock ~= door:checkDoorSide(victim) then
			aggressor_monster._owner:open()
		end
	end
	
end



-- Continuity Functions
-----------------------------------------------------------
	
Stash.doors = function()

	if not Game._stash then
		Game._stash = {}
	end
	
	if not Game._stash[Level.index] then
		Game._stash[Level.index] = {}
	end

	Game._stash[Level.index].doors = {}
	Game._stash[Level.index].doorways = {}
	
	local stashed
	
	for k, door in ipairs(Doors) do
	
		Game._stash[Level.index].doors[k] = {}
		stashed = Game._stash[Level.index].doors[k]
	
		stashed.x, stashed.y, stashed.z = door.x, door.y, door.z
		stashed.polygon = door.polygon
		stashed.enable = door.enable
		stashed.lock = door.lock
		stashed.facing = door.facing
		stashed.state = door.state
		stashed.closeTimer = door.closeTimer
		
	end
	
	for k, doorway in ipairs(Doorways) do
	
		Game._stash[Level.index].doorways[k] = {}
		stashed = Game._stash[Level.index].doorways[k]
	
		stashed.enable = doorway.enable
		stashed.lock = doorway.lock
		
	end
	
end


Unstash.doors = function()
	
	if not Game._stash[Level.index] then
		return
	end

	local stashed

	for k, door in ipairs(Doors) do

		stashed = Game._stash[Level.index].doors[k]

		door.x, door.y, door.z = stashed.x, stashed.y, stashed.z
		door.polygon = stashed.polygon
		door.enable = stashed.enable
		door.lock = stashed.lock
		door.facing = stashed.facing
		door.state = stashed.state
		door.closeTimer = stashed.closeTimer

		door:updateAllObjectPositions()
	
	end
	
	for k, doorway in ipairs(Doorways) do

		stashed = Game._stash[Level.index].doorways[k]
	
		doorway.enable = stashed.enable
		doorway.lock = stashed.lock
	
	end
	
end