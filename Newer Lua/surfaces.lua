--[[	Surfaces.lua (MPDX) by Ku-rin
		
		This script controls interaction with various features associated with map sides, floors, and ceilings. This includes transparent-side switch emulation.
	
]]

Surfaces = {["actions"] = {}, ["find"] = {}}

Surfaces.actions.signs = function(tx, ty)
	Players.print("Well, that's good to know.")
end
	
Surfaces.actions.grates = function(polygon)
	Players.print("grate!")
end

Surfaces.find.signs = function(target, x, y, z, polygon)

	if math.abs(polygon.ceiling.z - polygon.floor.z) > 0.5 then return false end

	local col = Surfaces.interactive.signs.collection
	local bit = Surfaces.interactive.signs.bitmap

	for s in polygon.sides() do
		if s.transparent.collection then
			if s.transparent.collection.index == col
			and s.transparent.texture_index == bit then
				Surfaces.actions.signs()
				return true
			end
		end
	end
	
	return false
	
end

Surfaces.find.grates = function(target, x, y, z, polygon)
	
	return false
	
end

function initSurfaces() -- Triggers.init

	Surfaces.interactive = {

		["grates"] = {
			["collection"] = 20,
			["bitmap"] = 10
		},
	
		["signs"] = {
			["collection"] = 20,
			["bitmap"] = 44
		}

	}		

	setupConveyors()
	setupSwitches()

end


function setupConveyors()

	-- Conveyor annotation syntax: "Conveyor(direction, speed, active, id)"

	local conveyorQueue = findCommandAnnotations("Conveyor")
	
	if not conveyorQueue then return end
	
	for k, v in pairs(conveyorQueue) do

		local data = processAnnotationCommand(v)
		
		local conveyor = {}
		conveyor.polygon = v.polygon
		
		if # data.parameters == 1 then
			
			conveyor.id = data.parameters[1]
			
			if Level._conveyors[Level.index][conveyor.id] then
				
				local defined = Level._conveyors[Level.index][conveyor.id]
				conveyor = mergeTableKeys(conveyor, defined)
				
				installConveyor(conveyor)
				
			end
			
		else
		
			conveyor.direction = data.parameters[1]
			conveyor.speed = data.parameters[2]
			
			-- Optional
			conveyor.active = true
			conveyor.id = nil
		
			if data.parameters[3] ~= nil then conveyor.active = data.parameters[3] end
			if data.parameters[4] ~= nil then conveyor.id = data.parameters[4] end
		
			installConveyor(conveyor)
		
		end
		
	end
	
end


function setupSwitches()
	
	-- Switch annotation syntax: "Switch(type, target, enable, keys, id)"

	local switchQueue = findCommandAnnotations("Switch")
	
	if not switchQueue then return end

	for k, v in pairs(switchQueue) do

		local data = processAnnotationCommand(v)
		
		local switch = {}
		
		switch.polygon = v.polygon
		switch.side = getSwitchSide(v.polygon)
		
		if # data.parameters == 1 then
			
			switch.id = data.parameters[1]
			
			if Level._switches[Level.index][switch.id] then
				local defined = Level._switches[Level.index][switch.id]
				switch = mergeTableKeys(switch, defined)
				installSwitch(switch)
			end
				
		else
		
			switch.type = data.parameters[1]
			switch.target = data.parameters[2]
			
			-- Optional
			switch.enable = true
			switch.keys = nil
			switch.id = nil
		
			if data.parameters[3] ~= nil then switch.enable = data.parameters[3] end
			if data.parameters[4] ~= nil then switch.keys = data.parameters[4] end
			if data.parameters[5] ~= nil then switch.id = data.parameters[5] end
			
			installSwitch(switch)
			
		end
			
	end

end



-- Surfaces
-----------------------------------------------------------

function Surfaces.evaluate(target, x, y, z, polygon)

	if polygon._switch then
		polygon._switch:interaction()
		return true
	else
		local interactive = v
		
		if is_side(target) 
		or is_polygon_floor(target) 
		or is_polygon_ceiling(target) then
			for k, v in pairs(Surfaces.interactive) do
				if Surfaces.find[k](target, x, y, z, polygon) then
					return true
				end
			end
		end
	end
	
	return false
	
end



-- Conveyors
-----------------------------------------------------------

Conveyor = {}

Conveyors = {}


function Conveyor:new(o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end


function installConveyor(parameters)

	local conveyor = Conveyor:new()
	
	conveyor.id = parameters.id
	conveyor.direction = parameters.direction
	conveyor.speed = parameters.speed / 1024 -- WU/Tick (Use powers of two to avoid texture/object offsets.)
	conveyor.active = parameters.active
	conveyor.polygons = { parameters.polygon }
	getConveyorPolygons(conveyor.polygons, parameters.polygon)
	
	table.insert(Conveyors, conveyor)
	
end


function getConveyorPolygons(t, polygon)
	
	for p in polygon:adjacent_polygons() do
		
		if p.floor.collection == polygon.floor.collection
		and p.floor.texture_index == polygon.floor.texture_index then
			
			if not inTable(t, p) then
				table.insert(t, p)
				getConveyorPolygons(t, p)
			end
			
		end
	end
end



-- Switches
-----------------------------------------------------------

Switch = {}

Switches = {}


function Switch:new(o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end


function installSwitch(parameters)

	local switch = Switch:new()
	
	switch.id = parameters.id
	switch.polygon = parameters.polygon
	switch.side = parameters.side
	switch.type = parameters.type
	switch.target = parameters.target
	switch.enable = parameters.enable
	switch.keys = parameters.keys
	
	switch.polygon._switch = switch
	
	-- Yeah, Lua don't tell you this, so...
	switch.platformExtendsFromFloor = parameters.platformExtendsFromFloor
	
	table.insert(Switches, switch)
	
end

function Switch:resolveTarget()

	local target
	if self.type == "elevator call" then
		target = findByID(Elevators, self.target)
		
	elseif self.type == "elevator control" then
		target = findByID(Elevators, self.target)
	
	elseif self.type == "light" then
		target = Lights[self.target]
	
	elseif self.type == "lock" then
		target = findByID(Doorways, self.target)
	
	elseif self.type == "platform" then
		for p in Platforms() do
			if p.polygon == Polygons[self.target] then
				target = p
				break
			end
		end
		
	elseif self.type == "power" then
		target = findByID(Switches, self.target, 2)
		if not target then
			target = findByID(Elevators, self.target)
		end
		
	elseif self.type == "tag" then
		target = Tags[self.target]
	end
	
	return target
	
end

function Switch:interaction()

	Players.print(self.id)
	Players.print(self.type)
	Players.print(self.target)
	Players.print(self.enable)
	Players.print(self.keys)

	if not self.enable then
		
		self.polygon:play_sound(23)
		
		Players.print(pickEntry(Switch.words.disabled))
			
		return

	elseif self.keys then
		
		if not playerHasKey(self.keys) then
			
			self.polygon:play_sound(11)
			
			Players.print(pickEntry(Switch.words.noKey))
			
			return
			
		end
		
	end
	
	local target = self:resolveTarget()
	
	if self.type == "elevator call" then
		self.polygon:play_sound(133)
		target:summon()
		
	elseif self.type == "elevator control" then
		self.polygon:play_sound(16)
		target:interaction()
	
	elseif self.type == "light" then
		
		if target.active then
			self.polygon:play_sound(13)
			target.active = false
		else
			self.polygon:play_sound(12)
			target.active = true
		end

	elseif self.type == "lock" then
		
		if target then
			self.polygon:play_sound(14)
			target:switchLock(150)
		end
	
	elseif self.type == "platform" then
		
		self.polygon:play_sound(195)
		
		if target.locked then
			if not target.active then
				target.active = true
			else
				if target.contracting then
					target.contracting = false
					target.extending = true
				else
					target.contracting = true
					target.extending = false
				end
			end
		else
			target.active = target.active == false
		end
	
	elseif self.type == "power" then
		
		self.polygon:play_sound(195)
		
		if type(target) == "table" then
			for k, v in ipairs(target) do
				v.enable = v.enable == false
			end
		else
			target.enable = target.enable == false
		end
		
	end
	
end

function getSwitchSide(polygon)
	
	for l in polygon.lines() do
	
		if l.has_transparent_side then
		
			local tSide
		
			if l.cw_polygon == polygon then
				tSide = l.ccw_side
			else
				tSide = l.cw_side
			end
		
			if tSide then
				return tSide.transparent
			else
				return false
			end
			
		end
		
	end
	
end


Switch.words = {}

Switch.words.noKey = {
"It should work, but nothing happens.",
"Hmm... It's locked?",
"Authorization DENIED!?",
"Locked, huh?",
"No dice, it must need a keycode."
}

Switch.words.disabled = {
"Doesn't seem to be connected.",
"It's not doing anything.",
"And... nothing! Damn.",
"Did you try unplugging and plugging it back in?",
"It doesn't seem to be working."
}


-- Trigger Functions
-----------------------------------------------------------

function surfacesIdleUpkeep()	-- Triggers.idle
	
	for i = 1, # Conveyors, 1 do
	
		local conveyor = Conveyors[i]
		
		if conveyor.active then
			
			local xd, yd = radToCart(conveyor.direction, conveyor.speed)
			
			Players[0].overlays[2].text = xd
			Players[0].overlays[3].text = conveyor.speed
			
			for k, v in pairs(conveyor.polygons) do
				
				local polygon = v
				polygon.floor.texture_x = ((polygon.floor.texture_x - xd) % 1)
				polygon.floor.texture_y = ((polygon.floor.texture_y - yd) % 1)
				
				for i in Items() do
					if i.polygon == polygon then
						i:position(i.x + xd, i.y + yd, i.z, getPolygonAtLoc(i.x + xd, i.y + yd, i.z))
					end
				end
				
				for m in Monsters() do
					if m.polygon == polygon then
						m:position(m.x + xd, m.y + yd, m.z, getPolygonAtLoc(m.x + xd, m.y + yd, m.z))
					end
				end
				
				for p in Players() do
					if p.polygon == polygon then
						p:position(p.x + xd, p.y + yd, p.z, getPolygonAtLoc(p.x + xd, p.y + yd, p.z))
					end
				end
				
				for s in Scenery() do
					if s.polygon == polygon and s.type._conveyable then
						s:position(s.x + xd, s.y + yd, s.z, getPolygonAtLoc(s.x + xd, s.y + yd, s.z))
					end
				end
				
			end
		end
	end
	
	for i = 1, # Switches, 1 do
		
		local switch = Switches[i]
		
		if switch.damaged then
			switch.side.texture_index = 3
		elseif not switch.enable then
			switch.side.texture_index = 2
		else
			
			local target = switch:resolveTarget()
			
			if not target then

			else
				
			if switch.type == "elevator call" or switch.type == "elevator control" then
				if target.status == "active" then
					switch.side.texture_index = 0
				elseif target.status == "inactive" then
					switch.side.texture_index = 1
				end
				
			elseif switch.type == "light" then
				if target.active then
					switch.side.texture_index = 0
				else
					switch.side.texture_index = 1
				end
			
			elseif switch.type == "lock" then
				if target then
					if target.lock == "none" then
						switch.side.texture_index = 0
					else
						switch.side.texture_index = 1
					end
				end
				
			elseif switch.type == "platform" then
				if target.locked then
					if target.active then
						if target.contracting then
							switch.side.texture_index = 0
						else
							switch.side.texture_index = 1
						end
					else
						if not target.contracting then
							switch.side.texture_index = 0
						else
							switch.side.texture_index = 1
						end
					end
					if switch.platformExtendsFromFloor then
						switch.side.texture_index = (switch.side.texture_index + 1) % 2
					end
				else
					if target.active then
						switch.side.texture_index = 0
					else
						switch.side.texture_index = 1
					end
				end
			
			elseif switch.type == "power" then
				if type(target) == "table" then
					local quorum = 0
					for k, v in ipairs(target) do
						if v.enable then
							quorum = quorum + 1
						else
							quorum = quorum - 1
						end
					end
					if quorum >= 0 then
						switch.side.texture_index = 0
					else
						switch.side.texture_index = 1
					end
				else
					if target.enable then
						switch.side.texture_index = 0
					else
						switch.side.texture_index = 1
					end
				end
			end
			end
			
		end
				
	end
		
end