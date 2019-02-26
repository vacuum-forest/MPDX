--[[	Panels.lua (MPDX) by Ku-rin
		
		Panels are 3d scenery objects with various modes of interactability.

			Camera Panel: Allows player to view through a camera object (see cameras.lua)

			General Panel: TBD
	
]]

Panels = {}

function initPanels()

	PanelTypes = {}
	
	PanelTypes["camera"] = {}
	PanelTypes["camera"].usage = "camera"
	PanelTypes["camera"].object = {}
	PanelTypes["camera"].object.active = "camera panel"
	PanelTypes["camera"].object.inactive = "camera panel inactive"
	PanelTypes["camera"].object.locked = "camera panel"
	PanelTypes["camera"].object.dead = "camera panel damaged"
	
	PanelTypes["general"] = {}
	PanelTypes["general"].usage = "camera"
	PanelTypes["general"].object = {}
	PanelTypes["general"].object.active = "camera panel"
	PanelTypes["general"].object.inactive = "camera panel inactive"
	PanelTypes["general"].object.locked = "camera panel"
	PanelTypes["general"].object.dead = "camera panel damaged"
	
	setUpPanels()
	
end

Panels.list = {}

function installPanel(name, type, status, target, action, modifier, x, y, height, facing, polygon)
	
	local panel = Panels:new()
	
	-- Set basic parameters
	
	panel.type = PanelTypes[type]
	panel.status = status
	panel.target = target
	panel.action = action
	panel.modifier = modifier
	panel.facing = facing
	panel.height = height + polygon.floor.height
	panel.polygon = polygon
	
	panel.lastLiveState = "active"
	
	panel.object = Scenery.new(x, y, panel.height, panel.polygon, PanelTypes[type].object[status])
	panel.object.facing = panel.facing
	panel.object._parent = panel
	
	Panels[name] = panel
	table.insert(Panels.list, panel)
	
end

function Panels:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Panels:interaction()

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

function Panels:repair()

	if self.status == "dead" then
		Players.print("I can fix it!")
		--Do repair shit here
		self:changeStatus(self.lastLiveState)
	end
	
end

function Panels:destroy()
	
	
	
end

function Panels:changeStatus(newState)

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

function setUpPanels()

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
			
			installPanel(t.name, t.type, t.status, t.target, t.action, t.modifier, a.x, a.y, t.height, t.facing, a.polygon)

		end
		
	end
	
end

function panelsIdleUpkeep()

	for i = 1, # Panels.list, 1 do
		if Panels.list[i].object.damaged then
			Panels.list[i]:changeStatus("dead")
		end
	end
	
end