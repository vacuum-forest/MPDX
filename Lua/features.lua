--[[	Features.lua (MPDX) by Ku-rin
		
		This script controls interaction with various features associated with map sides, floors, and ceilings. This includes transparent-side switch emulation.
	
]]

Features = {}

function initFeatures()

	for p in Polygons() do
	
		if p.area == 0 then -- Identify 'flat' polygons.
		
			for l in p.lines() do
			
				if l.has_transparent_side then
				
					local tSide
				
					if l.cw_polygon == p then
						
						tSide = l.ccw_side
						
					else
						
						tSide = l.cw_side
						
					end
				
					if tSide then
					
						if tSide.transparent.texture_index < 2 then
					
							p._switch = Features.switches.installSwitch(p, tSide)
					
						end
					
					end
				
				end
			
			end
		
		end
	
	end

end

Switches = {}
Features.switches = {}
Features.switches.lights = { ["disabled"] = 0.01, ["damaged"] = 0 }
Features.switches.list = {}

function Features.switches.installSwitch(polygon, side)

	local switch = Switches:new()
	
	switch.polygon = polygon
	switch.side = side
	switch.target = nil
	switch.status = "enabled"
	switch.key = nil
	switch.subtype = nil
	
	for a in Annotations() do
		
		if a.polygon == polygon and a.text:find("Key") then
			
			local n = filterCSVLine(a.text)

			switch.key = n[2]

			break
			
		end
		
	end
	
	if polygon.type == "platform on trigger" then
	
		switch.type = "platform"
		switch.target = Polygons[polygon.permutation].permutation
		
		if Platforms[switch.target].locked then
			switch.subtype = "toggle"
		else
			switch.subtype = "power"
		end
	
	end
	
	table.insert(Features.switches.list, switch)
	
	return switch
	
end

function Switches:interaction()

	if self.key then
		
		if not playerHasKey(self.key) then
			
			Players.print("It's locked.")
			
			return
			
		end
		
	end

	if self.status ~= "enabled" then
	
		Players.print("It doesn't seem to do anything.")
			
		return
		
	else

		if self.type == "platform" then
		
			local platform = Platforms[self.target]

			if self.subtype == "power" then

				if platform.active then
			
					platform.active = false
					self.side:play_sound(Sounds["switch off"])
			
				else
			
					platform.active = true
					self.side:play_sound(Sounds["switch on"])
			
				end
				
			else
			
				if not platform.active then
				
					platform.active = true
					self.side:play_sound(Sounds["switch on"])
					
				else
					
					if platform.contracting then
						
						platform.contracting = false
						platform.extending = true
						
					else
						
						platform.contracting = true
						platform.extending = false
					
					end
					
				end
				
			end
		
		end
		
		return
	
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

	if polygon._switch then
		
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
	
	for k,v in ipairs(Features.switches.list) do
	
		if v.polygon.floor.light.intensity == Features.switches.lights.disabled then
			
			v.side.transparent.texture_index = 2
			v.status = "disabled"
			
		elseif v.polygon.floor.light.intensity == Features.switches.lights.damaged then
			
			v.side.transparent.texture_index = 3
			v.status = "damaged"
			
		else
	
			if v.type == "platform" then
				local p = Platforms[v.target]
				
				if v.subtype == "power" then
				
					if p.active then
						v.side.transparent.texture_index = 0
					else
						v.side.transparent.texture_index = 1
					end
					
				else
				
					if p.active then
						if p.contracting then
							v.side.transparent.texture_index = 0
						else
							v.side.transparent.texture_index = 1
						end
					else
						if p.contracting then
							v.side.transparent.texture_index = 1
						else
							v.side.transparent.texture_index = 0
						end
					end
					
				end
				
			end
		
		end
		
	end
		
end