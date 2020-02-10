--[[	Doors.lua (MPDX) by Ku-rin
		
		This script handles the interaction and mechanics of 3d scenery doors.
	
]]

function initDoors()
	
	-- Door types --

	DoorTypes = {}
	
	DoorTypes.collider = {}
	DoorTypes.collider.radius = 32/1024
	DoorTypes.collider.maxCount = 5
	DoorTypes.collider.object = "door collision cylinder"

	DoorTypes["solid a"] = {}
	DoorTypes["solid a"].opens = "both"
	DoorTypes["solid a"].motion = "swing"
	DoorTypes["solid a"].halfWidth = 0.2375
	DoorTypes["solid a"].halfThick = 0.0315
	DoorTypes["solid a"].hingeAngle = 6.11944249	--Angle from hinge to door object center
	DoorTypes["solid a"].hingeRadius = 0.24019366	--Distance from hinge to door object center
	DoorTypes["solid a"].closeDelay = -1
	DoorTypes["solid a"].object = "door solid"
	DoorTypes["solid a"].handleset = "handleset a"
	DoorTypes["solid a"].offset = nil
	DoorTypes["solid a"].hasMirror = true
	
	DoorTypes["solid b"] = {}
	DoorTypes["solid b"].opens = "both"
	DoorTypes["solid b"].motion = "swing"
	DoorTypes["solid b"].halfWidth = 0.2375
	DoorTypes["solid b"].halfThick = 0.0315
	DoorTypes["solid b"].hingeAngle = 6.11944249	
	DoorTypes["solid b"].hingeRadius = 0.24019366
	DoorTypes["solid b"].closeDelay = 90
	DoorTypes["solid b"].object = "door solid"
	DoorTypes["solid b"].handleset = "handleset b"
	DoorTypes["solid b"].offset = nil
	DoorTypes["solid b"].hasMirror = true
	
	DoorTypes["solid c"] = {}
	DoorTypes["solid c"].opens = "both"
	DoorTypes["solid c"].motion = "swing"
	DoorTypes["solid c"].halfWidth = 0.2375
	DoorTypes["solid c"].halfThick = 0.0315
	DoorTypes["solid c"].hingeAngle = 6.11944249	
	DoorTypes["solid c"].hingeRadius = 0.24019366
	DoorTypes["solid c"].closeDelay = 90
	DoorTypes["solid c"].object = "door solid"
	DoorTypes["solid c"].handleset = "handleset c"
	DoorTypes["solid c"].offset = nil
	DoorTypes["solid c"].hasMirror = true
	
	DoorTypes["solid d"] = {}
	DoorTypes["solid d"].opens = "both"
	DoorTypes["solid d"].motion = "swing"
	DoorTypes["solid d"].halfWidth = 0.2375
	DoorTypes["solid d"].halfThick = 0.0315
	DoorTypes["solid d"].hingeAngle = 6.11944249	
	DoorTypes["solid d"].hingeRadius = 0.24019366
	DoorTypes["solid d"].closeDelay = 90
	DoorTypes["solid d"].object = "door solid"
	DoorTypes["solid d"].handleset = "handleset d"
	DoorTypes["solid d"].offset = nil
	DoorTypes["solid d"].hasMirror = true
	
	DoorTypes["glass a"] = {}
	DoorTypes["glass a"].opens = "both"
	DoorTypes["glass a"].motion = "swing"
	DoorTypes["glass a"].halfWidth = 0.2375
	DoorTypes["glass a"].halfThick = 0.0315
	DoorTypes["glass a"].hingeAngle = 6.11944249
	DoorTypes["glass a"].hingeRadius = 0.24019366	
	DoorTypes["glass a"].closeDelay = -1
	DoorTypes["glass a"].object = "door glass"
	DoorTypes["glass a"].handleset = "handleset a"
	DoorTypes["glass a"].offset = nil
	DoorTypes["glass a"].hasMirror = true
	
	DoorTypes["glass b"] = {}
	DoorTypes["glass b"].opens = "both"
	DoorTypes["glass b"].motion = "swing"
	DoorTypes["glass b"].halfWidth = 0.2375
	DoorTypes["glass b"].halfThick = 0.0315
	DoorTypes["glass b"].hingeAngle = 6.11944249	
	DoorTypes["glass b"].hingeRadius = 0.24019366
	DoorTypes["glass b"].closeDelay = 90
	DoorTypes["glass b"].object = "door glass"
	DoorTypes["glass b"].handleset = "handleset b"
	DoorTypes["glass b"].offset = nil
	DoorTypes["glass b"].hasMirror = true
	
	DoorTypes["glass c"] = {}
	DoorTypes["glass c"].opens = "both"
	DoorTypes["glass c"].motion = "swing"
	DoorTypes["glass c"].halfWidth = 0.2375
	DoorTypes["glass c"].halfThick = 0.0315
	DoorTypes["glass c"].hingeAngle = 6.11944249	
	DoorTypes["glass c"].hingeRadius = 0.24019366
	DoorTypes["glass c"].closeDelay = 90
	DoorTypes["glass c"].object = "door glass"
	DoorTypes["glass c"].handleset = "handleset c"
	DoorTypes["glass c"].offset = nil
	DoorTypes["glass c"].hasMirror = true
	
	DoorTypes["glass d"] = {}
	DoorTypes["glass d"].opens = "both"
	DoorTypes["glass d"].motion = "swing"
	DoorTypes["glass d"].halfWidth = 0.2375
	DoorTypes["glass d"].halfThick = 0.0315
	DoorTypes["glass d"].hingeAngle = 6.11944249	
	DoorTypes["glass d"].hingeRadius = 0.24019366
	DoorTypes["glass d"].closeDelay = 90
	DoorTypes["glass d"].object = "door glass"
	DoorTypes["glass d"].handleset = "handleset d"
	DoorTypes["glass d"].offset = nil
	DoorTypes["glass d"].hasMirror = true
	
	DoorTypes["automatic"] = {}
	DoorTypes["automatic"].opens = "none"
	DoorTypes["automatic"].motion = "slide"
	DoorTypes["automatic"].halfWidth = 0.233125
	DoorTypes["automatic"].halfThick = 0.0315
	DoorTypes["automatic"].hingeAngle = nil	
	DoorTypes["automatic"].hingeRadius = nil
	DoorTypes["automatic"].closeDelay = 90
	DoorTypes["automatic"].object = "door automatic"
	DoorTypes["automatic"].handleset = nil
	DoorTypes["automatic"].offset = nil
	DoorTypes["automatic"].hasMirror = false
	DoorTypes["automatic"].slideDistance = 0.375
	
	-- Doorset types --
	
	DoorSetTypes = {}
	
	DoorSetTypes["solid single a"] = {}
	DoorSetTypes["solid single a"].class = "single"
	DoorSetTypes["solid single a"].doors = "solid a"
	DoorSetTypes["solid single a"].collision = nil
	
	DoorSetTypes["solid single b"] = {}
	DoorSetTypes["solid single b"].class = "single"
	DoorSetTypes["solid single b"].doors = "solid b"
	DoorSetTypes["solid single b"].collision = nil
	
	DoorSetTypes["solid single c"] = {}
	DoorSetTypes["solid single c"].class = "single"
	DoorSetTypes["solid single c"].doors = "solid c"
	DoorSetTypes["solid single c"].collision = nil
	
	DoorSetTypes["solid single d"] = {}
	DoorSetTypes["solid single d"].class = "single"
	DoorSetTypes["solid single d"].doors = "solid d"
	DoorSetTypes["solid single d"].collision = nil
	
	DoorSetTypes["solid single d reverse"] = {}
	DoorSetTypes["solid single d reverse"].class = "single"
	DoorSetTypes["solid single d reverse"].doors = "solid d"
	DoorSetTypes["solid single d reverse"].collision = nil
	DoorSetTypes["solid single d reverse"].reversed = true
	
	DoorSetTypes["glass single a"] = {}
	DoorSetTypes["glass single a"].class = "single"
	DoorSetTypes["glass single a"].doors = "glass a"
	DoorSetTypes["glass single a"].collision = nil
	
	DoorSetTypes["glass single b"] = {}
	DoorSetTypes["glass single b"].class = "single"
	DoorSetTypes["glass single b"].doors = "glass b"
	DoorSetTypes["glass single b"].collision = nil
	
	DoorSetTypes["glass single c"] = {}
	DoorSetTypes["glass single c"].class = "single"
	DoorSetTypes["glass single c"].doors = "glass c"
	DoorSetTypes["glass single c"].collision = nil
	
	DoorSetTypes["glass single d"] = {}
	DoorSetTypes["glass single d"].class = "single"
	DoorSetTypes["glass single d"].doors = "glass d"
	DoorSetTypes["glass single d"].collision = nil
	
	DoorSetTypes["glass single d reverse"] = {}
	DoorSetTypes["glass single d reverse"].class = "single"
	DoorSetTypes["glass single d reverse"].doors = "glass d"
	DoorSetTypes["glass single d reverse"].collision = nil
	DoorSetTypes["solid single d reverse"].reversed = true
	
	DoorSetTypes["solid double a"] = {}
	DoorSetTypes["solid double a"].class = "double"
	DoorSetTypes["solid double a"].doors = "solid a"
	DoorSetTypes["solid double a"].collision = nil
	
	DoorSetTypes["solid double b"] = {}
	DoorSetTypes["solid double b"].class = "double"
	DoorSetTypes["solid double b"].doors = "solid b"
	DoorSetTypes["solid double b"].collision = nil
	
	DoorSetTypes["solid double c"] = {}
	DoorSetTypes["solid double c"].class = "double"
	DoorSetTypes["solid double c"].doors = "solid c"
	DoorSetTypes["solid double c"].collision = nil
	
	DoorSetTypes["solid double d"] = {}
	DoorSetTypes["solid double d"].class = "double"
	DoorSetTypes["solid double d"].doors = "solid d"
	DoorSetTypes["solid double d"].collision = nil
	
	DoorSetTypes["glass double a"] = {}
	DoorSetTypes["glass double a"].class = "double"
	DoorSetTypes["glass double a"].doors = "glass a"
	DoorSetTypes["glass double a"].collision = nil
	
	DoorSetTypes["glass double b"] = {}
	DoorSetTypes["glass double b"].class = "double"
	DoorSetTypes["glass double b"].doors = "glass b"
	DoorSetTypes["glass double b"].collision = nil
	
	DoorSetTypes["glass double c"] = {}
	DoorSetTypes["glass double c"].class = "double"
	DoorSetTypes["glass double c"].doors = "glass c"
	DoorSetTypes["glass double c"].collision = nil
	
	DoorSetTypes["glass double d"] = {}
	DoorSetTypes["glass double d"].class = "double"
	DoorSetTypes["glass double d"].doors = "glass d"
	DoorSetTypes["glass double d"].collision = nil
	
	DoorSetTypes["automatic"] = {}
	DoorSetTypes["automatic"].class = "automatic"
	DoorSetTypes["automatic"].doors = "automatic"
	DoorSetTypes["automatic"].collision = {0.636, 0.233}
	
	DoorSetClasses = {}
	
	DoorSetClasses["single"] = {}
	DoorSetClasses["single"].frame = "doorframe single"
	DoorSetClasses["single"].doorCount = 1
	
	DoorSetClasses["double"] = {}
	DoorSetClasses["double"].frame = "doorframe double"
	DoorSetClasses["double"].doorCount = 2
	
	DoorSetClasses["automatic"] = {}
	DoorSetClasses["automatic"].frame = "doorframe automatic"
	DoorSetClasses["automatic"].doorCount = 2
	
	-- Set up doors in map --
	
	setupDoorways()
	
end


-- Doors: The actual door object --

Doors = {}

Doors.minAD = 1			-- Mimimum angular velocity in degrees/tick
Doors.maxAD = 4			-- Maximum angular velocity in degrees/tick

Doors.minLD = 0.0075	-- Minimum lateral velocity in WU/tick
Doors.maxLD = 0.025		-- Maximum lateral velocity in WU/tick

Doors.noises = {"open", "close", "locked", "aux"}


-- Instantiate a new door object
function installDoor(type, parent, sidedness, enable, lock, keyset)

	local door = Doors:new()
	Players.print(type)
	-- Set basic parameters
	
	door.type = DoorTypes[type]
	door.parent = parent
	door.enabled = enable
	door.lock = lock or "none"
	door.keyset = keyset or "none"
	
	-- Get position from parent (DoorSet)
	
	door.x = parent.x
	door.y = parent.y
	door.z = parent.z
	door.polygon = parent.polygon
	door.facing = parent.facing
	
	-- Set initial state
	
	door.state = "closed"	-- (closed, open, closing, opening)
	door.polygon.type = PolygonTypes["monster impassable"]
	
	-- Get additional parameters from DoorType
	
	door.opens = DoorTypes[type].opens -- (inside, outside, both, none)
	door.motion = DoorTypes[type].motion -- (swing, slide)
	
	if sidedness then
		door.orientation = sidedness -- (left, right)
	end
	
	door.halfWidth = DoorTypes[type].halfWidth -- ([WU])
	door.halfThick = DoorTypes[type].halfThick -- ([WU])
	door.hingeAngle = DoorTypes[type].hingeAngle or nil -- ([deg])
	door.hingeRadius = DoorTypes[type].hingeRadius or nil -- ([WU])
	
	-- Create scenery object
	door.scenery = DoorTypes[type].object
	
	if door.type.hasMirror then
		if sidedness == "right" then
			door.scenery = door.scenery .. " r"
		elseif sidedness == "left" then
			door.scenery = door.scenery .. " l"
		end
	end
	
	door.object = Scenery.new(door.x, door.y, door.z, door.polygon, door.scenery)
	door.object.facing = door.facing
	door.object:position(door.x, door.y, door.z, door.polygon)
	door.object._owner = door
	
	-- Create handle
	if DoorTypes[type].handleset then
		
		if sidedness == "right" then
			door.handler = DoorTypes[type].handleset .. " r"
		elseif sidedness == "left" then
			door.handler = DoorTypes[type].handleset .. " l"
		end
		
		door.handle = Scenery.new(door.x, door.y, door.z, door.polygon, door.handler)
		door.handle.facing = door.facing
		door.handle:position(door.x, door.y, door.z, door.polygon)
		door.handle._owner = door
		
	end
	
	if type == "elevator l" then
		door.object.facing = door.object.facing + 180
	end
	
	-- Offset double door positions
	
	if parent.class == "double" or parent.class == "automatic" then
		
		if door.type.offset then
			
			-- Flip right door
			if door.orientation == "left" then
				door.facing = door.facing + 180
				door.object.facing = door.facing
				door.isReversed = true
			end
			
			local dt = door.facing - 90
			local nx, ny = radToCart(dt, door.type.offset)
			door.x = door.x + nx
			door.y = door.y + ny
			door.object:position(door.x, door.y, door.z, door.polygon)
			door.handle:position(door.x, door.y, door.z, door.polygon)
			
		else
		
			local dt -- Direction of travel
			if door.orientation == "right" then
				dt = door.facing + 90
			else
				dt = door.facing - 90
			end
		
			local nx, ny = radToCart(dt, door.halfWidth)
			door.x = door.x + nx
			door.y = door.y + ny
			door.object:position(door.x, door.y, door.z, door.polygon)
			
			if door.handle then
				door.handle:position(door.x, door.y, door.z, door.polygon)
			end
			
			door.isReversed = false
			
		end
		
	end
	
	-- Establish motion parameters
	
	if door.motion == "swing" then -- Set up hinge position, angles for swingers
		
		door.closedAngle = door.facing
		
		local hx, hy, dt
		
		if door.orientation == "right" then
			dt = door.facing + 90 - door.hingeAngle
			door.baseOpenAngle = door.facing + 90
			door.openAngle = door.baseOpenAngle
		else
			dt = door.facing - 90 + door.hingeAngle
			door.baseOpenAngle = door.facing - 90
			door.openAngle = door.baseOpenAngle
		end
		
		hx, hy = radToCart(dt, door.hingeRadius)
		door.hingeX = door.x + hx
		door.hingeY = door.y + hy
		
	elseif door.motion == "slide" then -- Set up open, closed positions for sliders
		
		local openDistance
		if DoorTypes[type].offset then
			openDistance = DoorTypes[type].offset * 2
		elseif DoorTypes[type].slideDistance then
			openDistance = DoorTypes[type].slideDistance
		else
			openDistance = door.halfWidth * 2
		end
		
		local ox, oy
		
		door.xClosed = door.x
		door.yClosed = door.y
		
		if door.orientation == "right" then
			ox, oy = radToCart(door.facing + 90, openDistance)
		else
			if door.isReversed then
				ox, oy = radToCart(door.facing + 90, openDistance)
			else
				ox, oy = radToCart(door.facing - 90, openDistance)
			end
		end
		
		door.xOpen = door.x + ox
		door.yOpen = door.y + oy
		
	else -- Something went horribly wrong!
		
		return nil
		
	end
	
	-- Set up door colliders
	
	door.colliders = {}
	
	local numCol = math.floor(door.halfWidth / DoorTypes.collider.radius) -- Number of colliders to place
	
	if numCol % 2 == 0 then -- Keep odd number of colliders per door
		numCol = numCol - 1 
	end
	
	numCol = math.min(numCol, DoorTypes.collider.maxCount) -- Limit maximum number of colliders (if so ordained)
	
	door.colliderSpacing = math.min((door.halfWidth - DoorTypes.collider.radius / 2) * 2, 1) / numCol -- Distance between colliders
	
	local count = math.floor(numCol / 2)
	
	local cxo, cyo
	if door.motion == "swing" then
		cxo, cyo = radToCart(door.facing, door.halfThick / 2)
	else
		cxo, cyo = radToCart(door.facing - 180, door.halfThick / 2)
	end
	
	for i = -count, count, 1 do
		local cx, cy = radToCart(door.facing - 90, door.colliderSpacing * i)
		local col = Scenery.new(door.x, door.y, door.z, door.polygon, DoorTypes.collider.object)
		col:position(door.x + cx + cxo, door.y + cy + cyo, door.z, door.polygon)
		col._parent = door
		table.insert(door.colliders, col)
	end
	
	-- Set up closing timer
	
	if door.type.closeDelay > 0 then
		door.closeTimer = 0
		door.closeDelay = door.type.closeDelay
	end
	
	return door
	
end

	
function Doors:getDirection(angle)
	
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
	
	if self.isReversed then
		dir = dir * -1
	end

	return dir

end


function Doors:getAngleDeflection()

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
	
	if alpha < Doors.minAD then
		return alpha
	end
	
	angle = math.max(Doors.maxAD * math.sin(math.pi * (alpha / sweep)), Doors.minAD)
	
	return angle
	
end


function Doors:getLinearDeflection()
	
	local deltaX, deltaY
	local sweepX = math.abs(self.xOpen - self.xClosed)	-- Total Deflections
	local sweepY = math.abs(self.yOpen - self.yClosed)
	
	if self.state == "opening" then
		deltaX = math.abs(self.xOpen - self.x)
		deltaY = math.abs(self.yOpen - self.y)
	elseif self.state == "closing" then
		deltaX = math.abs(self.xClosed - self.x)
		deltaY = math.abs(self.yClosed - self.y)
	else
		return
	end
	
	-- Motion Speed Easing
	local defX, defY
	
	if deltaX >= Doors.minLD then
		defX = math.max(Doors.maxLD * math.sin(math.pi * deltaX / sweepX), Doors.minLD)
	else
		defX = deltaX
	end	
	
	if deltaY >= Doors.minLD then
		defY = math.max(Doors.maxLD * math.sin(math.pi * deltaY / sweepY), Doors.minLD)
	else
		defY = deltaY
	end	

	return defX, defY
	
end


function Doors:move()

	local direction = self:getDirection()

	-- Swinging doors
	if self.motion == "swing" then
		
		local angle = self:getAngleDeflection()
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
		
		-- Pass updates to scenery object
		self.object.facing = self.facing
		self.object:position(self.x, self.y, self.z, self.polygon)
		
		for p in Polygons() do
			if p:contains(self.x, self.y) then
				if self.z < p.ceiling.z and self.z >= p.floor.z then
					self.polygon = p
					self.object:position(self.x, self.y, self.z, self.polygon)
					break
				end
			end
		end
		
		-- Stop door if end reached
		if self.state == "opening" then
			if self.facing == self.openAngle then
				self:stop()
			end
		elseif self.state == "closing" then
			if self.facing == self.closedAngle then
				self:stop()
			end
		else
			self:stop()
		end
		
	-- Sliding doors
	else
	
		if self.facing >= 90 and self.facing < 270 then
			direction = direction * -1
		end
	
		local dx, dy = self:getLinearDeflection()
		
		self.x = dx * direction + self.x
		self.y = dy * direction + self.y
		
		-- Pass updates to scenery object
		self.object:position(self.x, self.y, self.z, self.polygon)
		
		if dx == 0 and dy == 0 then
			self:stop()
		end
	
	end
	
	self:updateColliders()

end


function Doors:start()
		
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
			
			self:noise("open")
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
			
					if self.closeDelay then
						self.closeTimer = self.closeDelay / 2
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
			
			self:noise("close")
			self.state = "closing"
			
		end
		
	end
	
end


function Doors:stop()

	if self.state == "open" or self.state == "closed" then
		return
	else
		if self.state == "opening" then
			self.state = "open"
			if self.closeDelay then					-- Reset the timer to close the doors if needed
				self.closeTimer = self.closeDelay
			end
		elseif self.state == "closing" then
			self.state = "closed"
		end
	end
	
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
		self.parent.polygon.type = PolygonTypes["normal"]
	elseif self.state == "closed" then
		self.parent.polygon.type = PolygonTypes["monster impassable"]
	end
	
end


function Doors:updateColliders()
	
	local cxo, cyo
	if self.motion == "swing" then
		cxo, cyo = radToCart(self.facing, self.halfThick / 2)
	else
		cxo, cyo = radToCart(self.facing - 180, self.halfThick / 2)
	end
	
	local count = # self.colliders
	count = math.floor(count / 2)

	local j = 1
	for i = -count, count, 1 do
		local cx, cy = radToCart(self.facing - 90, self.colliderSpacing * i)
		self.colliders[j]:position(self.x + cx + cxo, self.y + cy + cyo, self.z, self.polygon)
		j = j + 1
	end

	if self.handle then
		self.handle:position(self.x, self.y, self.z, self.polygon)
		self.handle.facing = self.facing
	end
	
end


function Doors:checkPlayerSide()

	local bearing = math.floor(getBearing(self, Players[0]) - self.facing)
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


function Doors:canUnlock()
	
	if self.keyset == "none" then
		return false
	end
	
	for i = 1, # self.keyset, 1 do
		if Keys[self.keyset[i]] then
			if Keys[self.keyset[i]].owner == Players[0] then
				return true
			end
		end
	end
	
	return false
	
end

function Doors:setState(state)

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
		self.parent.polygon.type = PolygonTypes["normal"]
	elseif self.state == "closed" then
		self.parent.polygon.type = PolygonTypes["monster impassable"]
	end
	
end


function Doors:interaction()

	if self.type.opens == "none" then
		return
	end
	
	if not self.enabled then
		
		if self.transit then
			
			if self.lock ~= "none" then
			
				if self.lock == "both" or self:checkPlayerSide() == self.lock then
					if not self:canUnlock() then
						Players[0]:print("It's locked.")
						return
					end
				end
		
			end
			
			levelTransition(self.transit)
			return
			
		else
		
			Players[0]:print("It doesn't seem to want to move at all.")
			return
			
		end
		
	end
	
	if self.state == "opening" or self.state == "closing" then
		
		return
		
	elseif self.state == "closed" then
		
		if self.type.opens == "both" then
			
			-- Don't worry!
			
		else
			
			if self:checkPlayerSide() ~= self.type.opens then
				Players[0]:print("You can't open it from this side.")
				return
			end
			
		end
		
		if self.lock ~= "none" then
			
			if self.lock == "both" or self:checkPlayerSide() == self.lock then
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


function Doors:noise(sound)

	local canHasSound = false
	for i = 1, # Doors.noises, 1 do
		canHasSound = sound == Doors.noises[i]
		if canHasSound then
			break
		end
	end
	
	if not canHasSound then
		return
	end

	local bloop = "door " .. self.motion .. " " .. sound

	self.object:play_sound(bloop)
	
end


function Doors:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end


-- DoorSets: Includes a doorframe (optional), and at least one door object --

DoorSets = {}

-- Instantiate a new doorset
function installDoorSet(id, type, x, y, z, polygon, facing, enable, lock, keyset)

	local doorSet = DoorSets:new()

	doorSet.id = id
	doorSet.type = DoorSetTypes[type]
	doorSet.class = doorSet.type.class
	doorSet.x = x
	doorSet.y = y
	doorSet.z = z
	doorSet.polygon = polygon
	doorSet.facing = facing
	doorSet.enable = enable
	doorSet.lock = lock
	doorSet.keyset = keyset
	
	local exit = getAnnotationContents("Exit", polygon, nil)
	if exit then
		doorSet.transit = {}
		doorSet.transit.level = tonumber(exit[2])
		doorSet.transit.id = tonumber(exit[3])
	end
	
	-- Create frame
	
	if DoorSetClasses[doorSet.class].frame then
		doorSet.frame = Scenery.new(x, y, z, polygon, SceneryTypes[DoorSetClasses[doorSet.class].frame])
		doorSet.frame.facing = facing
		doorSet.frame:position(x, y, z, polygon)
	end
	
	-- Create doors
	local door
	local sidedness
	
	doorSet.doors = {}
	for i = 1, DoorSetClasses[doorSet.class].doorCount, 1 do
		
		if i == 1 then
			if not doorSet.type.reversed then
				sidedness = "right"
			else
				sidedness = "left"
			end
		else
			sidedness = "left"
		end
		
		door = installDoor(doorSet.type.doors, doorSet, sidedness, enable, lock, keyset)
		
		if doorSet.transit then
			door.transit = doorSet.transit
		end
		
		table.insert(doorSet.doors, door)
		table.insert(Doors, door)
	end
	
	-- Optional Extra Colliders
	if doorSet.type.collision then
		
		local cOffset = doorSet.type.collision[1]
		local cRadius = doorSet.type.collision[2]
		local ccx, ccy, cca
		
		for i = -1, 1, 2 do
			
			cca = facing + (90 * i)
			ccx, ccy = radToCart(cca, cOffset)
			ccx = ccx + x
			ccy = ccy + y
			
			local numCol = math.floor(cRadius / DoorTypes.collider.radius)
	
			if numCol % 2 == 0 then
				numCol = numCol - 1 
			end
	
			numCol = math.min(numCol, 5)
	
			local colliderSpacing = cRadius * 2 / numCol
	
			local count = math.floor(numCol / 2)
	
			for j = -count, count, 1 do
				local cx, cy = radToCart(cca, colliderSpacing * j)
				local col = Scenery.new(x, y, z, polygon, DoorTypes.collider.object)
				col:position(ccx + cx, ccy + cy, z, polygon)
			end
			
		end
		
	end
	
	-- Elevator Doors
	if type == "elevator" then
	
		local elevatorID = tonumber(getAnnotationContents("Elevator", polygon, 2))
		
		if elevatorID then
			
			Elevators[elevatorID].door = doorSet
			
		end
		
	end
	
	-- Sliding Auto Door Opener
	if type == "automatic" then
		local opener = Monsters.new(x, y, z + 0.9, polygon, MonsterTypes["door daemon"])
		opener._parent = doorSet
	end
	
	-- Linkback from polygon
	polygon._doorSet = doorSet
	
	table.insert(DoorSets, doorSet)
	return doorSet

end

-- Trigger a doorset to open its doors simultaneously
function DoorSets:openSesame()

	if not self.enable then
		return
	end

	for i = 1, # self.doors, 1 do
	
		if self.doors[i].state == "closed" then
			self.doors[i]:start()
		end
		
	end
	
end

-- Bet you'll never guess what *this* does...
function DoorSets:closeSesame()

	if not self.enable then
		return
	end

	Players.print("Close Sesame!")

	for i = 1, # self.doors, 1 do
	
		Players.print(self.doors[i].state)
	
		if self.doors[i].state == "open" then
			self.doors[i]:start()
		end
		
	end
	
end

function DoorSets:switchLock(timer)
	
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
				for i = 1, # self.doors, 1 do
					self.doors[i].lock = self.lock
				end
			end
		
			createTimer(timer, false, resetLock)
			
		end
	
	elseif self.lastLock then
		
		self.lock = self.lastLock
		self.lastLock = nil
		for i = 1, # self.doors, 1 do
			self.doors[i].lock = self.lock
		end
	
	end
	
end

function DoorSets:new()

	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end


-- Already called inside of initDoors()
function setupDoorways()
	
	for s in Scenery() do
		
		if s.type == "door placeholder" then -- "Light Dirt" in Weyland, FYI. Marks the door's polygon and facing.
			
			-- Center the placeholder in the polygon
			s:position(s.polygon.x, s.polygon.y, s.polygon.z, s.polygon)
			
			local note = getAnnotationContents("Door", s.polygon, nil)
			
			-- Every door needs an annotation in the same polygon as the placeholder scenery.
			-- Syntax: "Door, id (or nil), doorset_type, enabled (true/false), locked (inside, outside, both, none), keys (semicolon-separated list)"
			-- Do not include extra whitespace in any part of your annotation.
			
			if note then

				local id = note[2] or nil
				local type = note[3]
				local enabled = note[4] == "true"
				local locked = note[5] or nil
				local keyset
				if note[6][1] then
					keyset = note[6]
				end
			 
				installDoorSet(id, type, s.x, s.y, s.z, s.polygon, s.facing, enabled, locked, keyset)
				s:delete()
				
			else
			
				assert(false, "Couldn't spawn doorway, no annotation found.")
				
			end
			
		end
		
	end
	
end

function getDoorSetByID(id)
	
	for n = 1, # DoorSets, 1 do
		
		if DoorSets[n].id == id then
			return DoorSets[n]
		end
		
	end
	
	return false
	
end

-- Include a call to this in Triggers.idle() or .postidle()
function doorsIdleUpkeep()

	for n = 1, # Doors, 1 do

		if Doors[n].state == "opening" or Doors[n].state == "closing" then
			Doors[n]:move()
		elseif Doors[n].state == "open" then
			if Doors[n].closeDelay then
				if Doors[n].closeTimer > 0 then
					Doors[n].closeTimer = Doors[n].closeTimer - 1
				else
					Doors[n]:start()
				end
			end
		end
		
	end
	
end

-- Watch for automatic door openings...
-- Note: Monsters immune to teleporter ('sensor') damage will not trigger auto-doors.

function doorsMDamagedUpkeep(aggressor_monster, damage_type)
	
	if damage_type == "sensor" and aggressor_monster.type == "door daemon" then
		aggressor_monster._parent:openSesame()
	end

end

function doorsPDamagedUpkeep(aggressor_monster, damage_type)
	
	if damage_type == "sensor" and aggressor_monster.type == "door daemon" then
		aggressor_monster._parent:openSesame()
	end

end