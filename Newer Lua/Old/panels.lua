--[[	Features.lua (MPDX) by Ku-rin
		
		This script controls interaction with various features associated with map sides, floors, and ceilings. This includes transparent-side switch emulation.
	
]]

Features = {}

function initFeatures()

	setupSwitches()

end

Switches = {}

function setupSwitches()

	for p in Polygons() do
		if p.type == "glue trigger" then
			local switch = getAnnotationContents("Switch", p)
			if switch then
				installSwitch(p, getSwitchSide(p), switch)
			end
		end
	end
	
end

function installSwitch(polygon, side, switchData)

	local switch = Switches:new()
	
	switch.polygon = polygon
	switch.side = side
	switch.id = switchData[2]
	switch.type = switchData[3]
	switch.target = switchData[4]
	switch.key = switchData[5]
	switch.enabled = switchData[6] == "true"
	
	polygon._switch = switch
	table.insert(Switches, switch)
	
end

function Switches:interaction()

	Players.print("Switch found: " .. self.type)

	if self.key then
		
		if not playerHasKey(self.key) then
			
			Players.print("It's locked.")
			
			self.side:play_sound(Sounds["cant toggle switch"])
			
			return
			
		end
		
	end

	if not self.enabled then
	
		Players.print("It doesn't seem to work.")
			
		return
		
	else

		if self.type == "light" then
			local target = Lights[self.target]
			if target.active then
				target.active = false
			else
				target.active = true
			end

		elseif self.type == "lock" then
			local door = findDoorwayByID(self.target)
			if door then
				door:switchLock(150)
			end
		
		
		elseif self.type == "power" then
			local target = Panels[self.target]
			target.enable = target.enable == false
		end
	
	end
	
end

function Switches:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Features.evaluate(o, x, y, z, polygon)

	local target
	local sidePart
	local hit = false
	
	Players.print ("Feature Evaluation...")

	if polygon._switch then
		Players.print ("Feature Eval: Switch Found!")
		polygon._switch:interaction()
		
		return true
		
	end

	if is_side(o) then
		sidePart = getSidePart(o, z)
		target = o[sidePart]	
	else
		target = o
	end
	
	local tex = { ["collection"] = target.collection, ["tindex"] = target.texture_index }
	
	return hit
	
end

Features.list = {}

Features.list.grates = { ["collection"] = 18, ["tindex"] = 9 }


function featuresIdleUpkeep()
	
	for i = 1, # Switches, 1 do
		local switch = Switches[i]
		
		if switch.type == "light" then
			local target = Lights[switch.target]
			if target.active then
				switch.side.texture_index = 0
			else
				switch.side.texture_index = 1
			end	
			
		elseif switch.type == "lock" then
			local target = findDoorwayByID(switch.target)
			if target then
				if target.lock == "none" then
					switch.side.texture_index = 0
				else
					switch.side.texture_index = 1
				end
			end
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