function initSwitches()

	SwitchTypes = {}
	
	local sourceTable = io.open("MPDX/Data/Tables/switchtypes.csv", "r")
	
	for i = 0, 1, 1 do --Fix this iteration BS with io.lines or something
		
		local filter = filterCSVLine(sourceTable:read())
		
		local set = {}
		
		local name = filter[1]
		
		SwitchTypes[name] = {}
		
		set.object = {}
		
		set.usage = filter[2]
		set.object.active = filter[3]
		set.object.inactive = filter[4]
		set.object.locked = filter[5]
		set.object.dead = filter[6]
		
		SwitchTypes[name] = set
		
	end
	
	sourceTable:close()
	
	setUpSwitches()
	
end


Switches = {}
Switches.list = {}

function installSwitch(name, type, status, target, action, modifier, x, y, height, facing, polygon)
	
	local switch = Switches:new()
	
	-- Set basic parameters
	
	switch.type = SwitchTypes[type]
	switch.status = status
	switch.target = target
	switch.action = action
	switch.modifier = modifier
	switch.facing = facing
	switch.height = height + polygon.floor.height
	switch.polygon = polygon
	
	switch.lastLiveState = "active"
	
	switch.object = Scenery.new(x, y, switch.height, switch.polygon, SwitchTypes[type].object[status])
	switch.object.facing = switch.facing
	switch.object._parent = switch
	
	Switches[name] = switch
	table.insert(Switches.list, switch)
	
end

function Switches:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Switches:interaction()

	if self.status == "active" then

		if self.type.usage == "camera" then
			Cams[self.target]:interaction(true)
		end

	elseif self.status == "dead" then
		
		Players.print("This panel looks like it's been damaged. It doesn't seem to work at all.")
	
	elseif self.status == "locked" then
		
		Players.print("This panel seems to be locked, you can't use it.")
		
	else
		
		Players.print("This panel doesn't seem to be active.")
	
	end
	
end

function Switches:repair()

	if self.status == "dead" then
		Players.print("I can fix it!")
		--Do repair shit here
		self:changeStatus(self.lastLiveState)
	end
	
end

function Switches:destroy()
	
	
	
end

function Switches:changeStatus(newState)

	if newState == "dead" then
		self.lastLiveState = self.status
		if self.type.usage == "camera" then
			if Player.camera.current == self.target then
				self.target:stop()
			end
		end
	end

	self.object = swapScenery(self.object, self.type.object[newState])
	self.status = newState
	
end

function setUpSwitches()

	local note = {}

	for a in Annotations() do
		
		if a.text:find("Panel") == 1 then
			
			note = filterCSVLine(a.text)
			
			local t = {}
			t.name = note[2]
			t.type = note[3]
			t.status = note[4]
			
			for i = 5, 7, 1 do
				if note[i] == "nil" or note[i] == " " then
					note[i] = nil
				end
			end
			
			t.target = note[5]
			t.action = note[6]
			t.modifier = note[7]
			
			t.height = tonumber(note[8])
			t.facing = tonumber(note[9])
			t.polygon = a.polygon
			
			installSwitch(t.name, t.type, t.status, t.target, t.action, t.modifier, a.x, a.y, t.height, t.facing, a.polygon)

		end
		
	end
	
end

function switchesIdleUpkeep()

	for i = 1, # Switches.list, 1 do
		if Switches.list[i].object.damaged then
			Switches.list[i]:changeStatus("dead")
		end
	end
	
end