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

	DoorTypes["hatch 1"] = {}
	DoorTypes["hatch 1"].opens = "both"
	DoorTypes["hatch 1"].motion = "swing"
	DoorTypes["hatch 1"].orientation = "left"
	DoorTypes["hatch 1"].halfWidth = 0.22
	DoorTypes["hatch 1"].halfThick = 0.037
	DoorTypes["hatch 1"].hingeAngle = 9.54676692	--Angle from hinge to door object center
	DoorTypes["hatch 1"].hingeRadius = 0.22308967	--Distance from hinge to door object center
	DoorTypes["hatch 1"].closeDelay = -1
	DoorTypes["hatch 1"].object = "door swing hatch"
	DoorTypes["hatch 1"].offset = nil

	DoorTypes["swing 1a l"] = {}
	DoorTypes["swing 1a l"].opens = "both"
	DoorTypes["swing 1a l"].motion = "swing"
	DoorTypes["swing 1a l"].orientation = "left"
	DoorTypes["swing 1a l"].halfWidth = 0.247
	DoorTypes["swing 1a l"].halfThick = 0.02725
	DoorTypes["swing 1a l"].hingeAngle = 6.32101859		--Angle from hinge to door object center
	DoorTypes["swing 1a l"].hingeRadius = 0.24750467	--Distance from hinge to door object center
	DoorTypes["swing 1a l"].closeDelay = -1
	DoorTypes["swing 1a l"].object = "door swing 1a l"
	DoorTypes["swing 1a l"].offset = nil
	
	DoorTypes["swing 1b l"] = {}
	DoorTypes["swing 1b l"].opens = "both"
	DoorTypes["swing 1b l"].motion = "swing"
	DoorTypes["swing 1b l"].orientation = "left"
	DoorTypes["swing 1b l"].halfWidth = 0.247
	DoorTypes["swing 1b l"].halfThick = 0.02725
	DoorTypes["swing 1b l"].hingeAngle = 6.32101859
	DoorTypes["swing 1b l"].hingeRadius = 0.24750467
	DoorTypes["swing 1b l"].closeDelay = 60
	DoorTypes["swing 1b l"].object = "door swing 1b l"
	DoorTypes["swing 1b l"].offset = nil
	
	DoorTypes["swing 1c l"] = {}
	DoorTypes["swing 1c l"].opens = "inside"
	DoorTypes["swing 1c l"].motion = "swing"
	DoorTypes["swing 1c l"].orientation = "left"
	DoorTypes["swing 1c l"].halfWidth = 0.247
	DoorTypes["swing 1c l"].halfThick = 0.02725
	DoorTypes["swing 1c l"].hingeAngle = 6.32101859
	DoorTypes["swing 1c l"].hingeRadius = 0.24750467
	DoorTypes["swing 1c l"].closeDelay = 60
	DoorTypes["swing 1c l"].object = "door swing 1c l"
	DoorTypes["swing 1c l"].offset = nil
	
	DoorTypes["swing 1a r"] = {}
	DoorTypes["swing 1a r"].opens = "both"
	DoorTypes["swing 1a r"].motion = "swing"
	DoorTypes["swing 1a r"].orientation = "right"
	DoorTypes["swing 1a r"].halfWidth = 0.247
	DoorTypes["swing 1a r"].halfThick = 0.02725
	DoorTypes["swing 1a r"].hingeAngle = 6.32101859
	DoorTypes["swing 1a r"].hingeRadius = 0.24750467
	DoorTypes["swing 1a r"].closeDelay = -1
	DoorTypes["swing 1a r"].object = "door swing 1a r"
	DoorTypes["swing 1a r"].offset = nil
	
	DoorTypes["swing 1b r"] = {}
	DoorTypes["swing 1b r"].opens = "both"
	DoorTypes["swing 1b r"].motion = "swing"
	DoorTypes["swing 1b r"].orientation = "right"
	DoorTypes["swing 1b r"].halfWidth = 0.247
	DoorTypes["swing 1b r"].halfThick = 0.02725
	DoorTypes["swing 1b r"].hingeAngle = 6.32101859
	DoorTypes["swing 1b r"].hingeRadius = 0.24750467
	DoorTypes["swing 1b r"].closeDelay = 60
	DoorTypes["swing 1b r"].object = "door swing 1b r"
	DoorTypes["swing 1b r"].offset = nil
	
	DoorTypes["swing 1c r"] = {}
	DoorTypes["swing 1c r"].opens = "inside"
	DoorTypes["swing 1c r"].motion = "swing"
	DoorTypes["swing 1c r"].orientation = "right"
	DoorTypes["swing 1c r"].halfWidth = 0.247
	DoorTypes["swing 1c r"].halfThick = 0.02725
	DoorTypes["swing 1c r"].hingeAngle = 6.32101859
	DoorTypes["swing 1c r"].hingeRadius = 0.24750467
	DoorTypes["swing 1c r"].closeDelay = 60
	DoorTypes["swing 1c r"].object = "door swing 1c r"
	DoorTypes["swing 1c r"].offset = nil
	
	DoorTypes["slide auto l"] = {}
	DoorTypes["slide auto l"].opens = "none"
	DoorTypes["slide auto l"].motion = "slide"
	DoorTypes["slide auto l"].orientation = "left"
	DoorTypes["slide auto l"].halfWidth = 0.2025
	DoorTypes["slide auto l"].halfThick = 0.0275
	DoorTypes["slide auto l"].hingeAngle = nil
	DoorTypes["slide auto l"].hingeRadius = nil
	DoorTypes["slide auto l"].closeDelay = 60
	DoorTypes["slide auto l"].object = "door slide auto"
	DoorTypes["slide auto l"].offset = nil
	
	DoorTypes["slide auto r"] = {}
	DoorTypes["slide auto r"].opens = "none"
	DoorTypes["slide auto r"].motion = "slide"
	DoorTypes["slide auto r"].orientation = "right"
	DoorTypes["slide auto r"].halfWidth = 0.2025
	DoorTypes["slide auto r"].halfThick = 0.0275
	DoorTypes["slide auto r"].hingeAngle = nil
	DoorTypes["slide auto r"].hingeRadius = nil
	DoorTypes["slide auto r"].closeDelay = 60
	DoorTypes["slide auto r"].object = "door slide auto"
	DoorTypes["slide auto r"].offset = nil
	
	DoorTypes["slide manual l"] = {}
	DoorTypes["slide manual l"].opens = "both"
	DoorTypes["slide manual l"].motion = "slide"
	DoorTypes["slide manual l"].orientation = "left"
	DoorTypes["slide manual l"].halfWidth = 0.22325
	DoorTypes["slide manual l"].halfThick = 0.0190
	DoorTypes["slide manual l"].hingeAngle = nil
	DoorTypes["slide manual l"].hingeRadius = nil
	DoorTypes["slide manual l"].closeDelay = -1
	DoorTypes["slide manual l"].object = "door slide manual"
	DoorTypes["slide manual l"].offset = 0.21075
	
	DoorTypes["slide manual r"] = {}
	DoorTypes["slide manual r"].opens = "both"
	DoorTypes["slide manual r"].motion = "slide"
	DoorTypes["slide manual r"].orientation = "right"
	DoorTypes["slide manual r"].halfWidth = 0.22325
	DoorTypes["slide manual r"].halfThick = 0.0190
	DoorTypes["slide manual r"].hingeAngle = nil
	DoorTypes["slide manual r"].hingeRadius = nil
	DoorTypes["slide manual r"].closeDelay = -1
	DoorTypes["slide manual r"].object = "door slide manual"
	DoorTypes["slide manual r"].offset = 0.21075
	
	DoorTypes["elevator l"] = {}
	DoorTypes["elevator l"].opens = "none"
	DoorTypes["elevator l"].motion = "slide"
	DoorTypes["elevator l"].orientation = "left"
	DoorTypes["elevator l"].halfWidth = 0.25
	DoorTypes["elevator l"].halfThick = 0.115
	DoorTypes["elevator l"].hingeAngle = nil
	DoorTypes["elevator l"].hingeRadius = nil
	DoorTypes["elevator l"].closeDelay = 180
	DoorTypes["elevator l"].object = "door elevator"
	DoorTypes["elevator l"].offset = nil
	
	DoorTypes["elevator r"] = {}
	DoorTypes["elevator r"].opens = "none"
	DoorTypes["elevator r"].motion = "slide"
	DoorTypes["elevator r"].orientation = "right"
	DoorTypes["elevator r"].halfWidth = 0.25
	DoorTypes["elevator r"].halfThick = 0.115
	DoorTypes["elevator r"].hingeAngle = nil
	DoorTypes["elevator r"].hingeRadius = nil
	DoorTypes["elevator r"].closeDelay = 180
	DoorTypes["elevator r"].object = "door elevator"
	DoorTypes["elevator r"].offset = nil

	
	-- Doorset types --
	
	DoorSetTypes = {}
	
	DoorSetTypes["swing single hatch"] = {}
	DoorSetTypes["swing single hatch"].class = "single"
	DoorSetTypes["swing single hatch"].doors = {"hatch 1"}
	DoorSetTypes["swing single hatch"].frame = "frame swing hatch"
	DoorSetTypes["swing single hatch"].collision = nil
	
	DoorSetTypes["swing single a"] = {}
	DoorSetTypes["swing single a"].class = "single"
	DoorSetTypes["swing single a"].doors = {"swing 1a l"}
	DoorSetTypes["swing single a"].frame = "frame swing single"
	DoorSetTypes["swing single a"].collision = nil
	
	DoorSetTypes["swing single b"] = {}
	DoorSetTypes["swing single b"].class = "single"
	DoorSetTypes["swing single b"].doors = {"swing 1b l"}
	DoorSetTypes["swing single b"].frame = "frame swing single"
	DoorSetTypes["swing single b"].collision = nil
	
	DoorSetTypes["swing single c"] = {}
	DoorSetTypes["swing single c"].class = "single"
	DoorSetTypes["swing single c"].doors = {"swing 1c l"}
	DoorSetTypes["swing single c"].frame = "frame swing single"
	DoorSetTypes["swing single c"].collision = nil
	
	DoorSetTypes["swing double a"] = {}
	DoorSetTypes["swing double a"].class = "double"
	DoorSetTypes["swing double a"].doors = {"swing 1a l", "swing 1a r"}
	DoorSetTypes["swing double a"].frame = "frame swing double"
	DoorSetTypes["swing double a"].collision = nil
	
	DoorSetTypes["swing double b"] = {}
	DoorSetTypes["swing double b"].class = "double"
	DoorSetTypes["swing double b"].doors = {"swing 1b l", "swing 1b r"}
	DoorSetTypes["swing double b"].frame = "frame swing double"
	DoorSetTypes["swing double b"].collision = nil
	
	DoorSetTypes["swing double c"] = {}
	DoorSetTypes["swing double c"].class = "double"
	DoorSetTypes["swing double c"].doors = {"swing 1c l", "swing 1c r"}
	DoorSetTypes["swing double c"].frame = "frame swing double"
	DoorSetTypes["swing double c"].collision = nil
	
	DoorSetTypes["slide automatic"] = {}
	DoorSetTypes["slide automatic"].class = "double"
	DoorSetTypes["slide automatic"].doors = {"slide auto l", "slide auto r"}
	DoorSetTypes["slide automatic"].frame = "frame slide auto"
	DoorSetTypes["slide automatic"].collision = {0.625, 0.25}
	
	DoorSetTypes["slide manual"] = {}
	DoorSetTypes["slide manual"].class = "double"
	DoorSetTypes["slide manual"].doors = {"slide manual l", "slide manual r"}
	DoorSetTypes["slide manual"].frame = "frame slide manual"
	DoorSetTypes["slide manual"].collision = nil
	
	DoorSetTypes["elevator"] = {}
	DoorSetTypes["elevator"].class = "double"
	DoorSetTypes["elevator"].doors = {"elevator l", "elevator r"}
	DoorSetTypes["elevator"].frame = nil
	DoorSetTypes["elevator"].collision = nil

	
	-- Set up doors in map --
	
	setupDoorways()
	
end


-- Doors: The actual door object --

Doors = {}

Doors.minAD = 1			-- Mimimum angular velocity in degrees/tick
Doors.maxAD = 4			-- Maximum angular velocity in degrees/tick

Doors.minLD = 0.0075	-- Minimum lateral velocity in WU/tick
Doors.maxLD = 0.025	-- Maximum lateral velocity in WU/tick

Doors.noises = {"open", "close", "locked", "aux"}


-- Instantiate a new door object
function installDoor(type, parent, enable, lock, keyset)

	local door = Doors:new()
	
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
	door.orientation = DoorTypes[type].orientation -- (left, right)
	door.halfWidth = DoorTypes[type].halfWidth -- ([WU])
	door.halfThick = DoorTypes[type].halfThick -- ([WU])
	door.hingeAngle = DoorTypes[type].hingeAngle or nil -- ([deg])
	door.hingeRadius = DoorTypes[type].hingeRadius or nil -- ([WU])
	
	-- Create scenery object
	door.object = Scenery.new(door.x, door.y, door.z, door.polygon, DoorTypes[type].object)
	door.object.facing = door.facing
	door.object:position(door.x, door.y, door.z, door.polygon)
	door.object._owner = door
	
	if type == "elevator l" then
		door.object.facing = door.object.facing + 180
	end
	
	-- Offset double door positions
	
	if parent.class == "double" then
		
		if door.type.offset then
			
			-- Flip right door
			if door.orientation == "right" then
				door.facing = door.facing + 180
				door.object.facing = door.facing
				door.isReversed = true
			end
			
			local dt = door.facing - 90
			local nx, ny = radToCart(dt, door.type.offset)
			door.x = door.x + nx
			door.y = door.y + ny
			door.object:position(door.x, door.y, door.z, door.polygon)
			
		else
		
			local dt -- Direction of travel
			if door.orientation == "left" then
				dt = door.facing + 90
			else
				dt = door.facing - 90
			end
		
			local nx, ny = radToCart(dt, door.halfWidth)
			door.x = door.x + nx
			door.y = door.y + ny
			door.object:position(door.x, door.y, door.z, door.polygon)
			
			door.isReversed = false
			
		end
		
	end
	
	-- Establish motion parameters
	
	if door.motion == "swing" then -- Set up hinge position, angles for swingers
		
		door.closedAngle = door.facing
		
		local hx, hy, dt
		
		if door.orientation == "left" then
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
		else
			openDistance = door.halfWidth * 2
		end
		
		local ox, oy
		
		door.xClosed = door.x
		door.yClosed = door.y
		
		if door.orientation == "left" then
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
	
	door.colliderSpacing = math.min(door.halfWidth * 2, 0.4) / numCol -- Distance between colliders
	
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
		if self.orientation == "right" then
			dir = -1
		end
	elseif self.state == "closing" then
		if self.orientation == "left" then
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
		
		if self.orientation == "right" then
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
				if self.orientation == "left" then
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
		
		if self.orientation == "right" then
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
function installDoorSet(type, x, y, z, polygon, facing, enable, lock, keyset)

	local doorSet = DoorSets:new()

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
	if doorSet.type.frame then
		doorSet.frame = Scenery.new(x, y, z, polygon, SceneryTypes[doorSet.type.frame])
		doorSet.frame.facing = facing
		doorSet.frame:position(x, y, z, polygon)
	end
	
	-- Create doors
	local door
	doorSet.doors = {}
	for i = 1, # doorSet.type.doors, 1 do
		door = installDoor(doorSet.type.doors[i], doorSet, enable, lock, keyset)
		
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
	if type == "slide automatic" then
		local opener = Monsters.new(x, y, z + 0.75, polygon, MonsterTypes["door daemon"])
		opener.active = true
		opener._parent = doorSet
	end
	
	-- Linkback from polygon
	polygon._doorSet = doorSet
	
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
			-- Syntax: "Door, doorset_type, enabled (true/false), locked (inside, outside, both, none), keys (semicolon-separated list)"
			-- Do not include extra whitespace in any part of your annotation.

			if note then

				local type = note[2]
				local enabled = note[3] == "true"
				local locked = note[4] or nil
				local keyset
				if note[5][1] then
					keyset = note[5]
				end
			 
				installDoorSet(type, s.x, s.y, s.z, s.polygon, s.facing, enabled, locked, keyset)
				s:delete()
				
			else
			
				assert(false, "Couldn't spawn doorway, no annotation found.")
				
			end
			
		end
		
	end
	
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
-- Note: Monsters immune to Flickta Claw damage will not trigger auto-doors.

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