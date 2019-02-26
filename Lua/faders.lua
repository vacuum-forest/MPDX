function initFaders()

	--FadeTypes[0].mnemonic = ""
	--FadeTypes[1].mnemonic = ""
	--FadeTypes[2].mnemonic = ""
	--FadeTypes[3].mnemonic = ""
	--FadeTypes[4].mnemonic = ""
	--FadeTypes[5].mnemonic = ""
	--FadeTypes[6].mnemonic = ""
	--FadeTypes[7].mnemonic = ""
	--FadeTypes[8].mnemonic = ""
	--FadeTypes[9].mnemonic = ""
	--FadeTypes[10].mnemonic = ""
	--FadeTypes[11].mnemonic = ""
	--FadeTypes[12].mnemonic = ""
	--FadeTypes[13].mnemonic = ""
	--FadeTypes[14].mnemonic = ""
	--FadeTypes[15].mnemonic = ""
	--FadeTypes[16].mnemonic = ""
	--FadeTypes[17].mnemonic = ""
	--FadeTypes[18].mnemonic = ""
	--FadeTypes[19].mnemonic = ""
	--FadeTypes[20].mnemonic = ""
	--FadeTypes[21].mnemonic = ""
	--FadeTypes[22].mnemonic = ""
	--FadeTypes[23].mnemonic = ""
	FadeTypes[24].mnemonic = "flash"
	FadeTypes[25].mnemonic = "sleep"
	FadeTypes[26].mnemonic = "camera plain"
	FadeTypes[27].mnemonic = "camera nightvision"
	FadeTypes[28].mnemonic = "under goo"
	FadeTypes[29].mnemonic = "under water"
	FadeTypes[30].mnemonic = "under lava"
	FadeTypes[31].mnemonic = "under sewage"
	FadeTypes[32].mnemonic = "under jjaro"

end

function fadersIdleUpkeep()

	fadeTimers:update()

end

-- Timed Faders

fadeTimers = {}
fadeTimers.all = {}

function fadeTimers:update()
	
	for i = 1, # fadeTimers.all, 1 do
		
		if not fadeTimers.all[i].ticks then
			
			fadeTimers.all[i] = nil
			table.remove(fadeTimers.all, i)
			
		else
	
			fadeTimers.all[i].ticks = fadeTimers.all[i].ticks - 1
	
			if fadeTimers.all[i].ticks == 0 then
		
				fadeTimers.all[i]:trigger()
		
				if fadeTimers.all[i].period then
					fadeTimers.all[i].ticks = fadeTimers.all[i].period
				end
		
			elseif fadeTimers.all[i].ticks < 0 then
	
				fadeTimers.all[i] = nil
				table.remove(fadeTimers.all, i)
		
			end
			
		end
			
	end
	
end

function fadeTimers:set(fader, ticks, period)

	if not FadeTypes[fader] then return end
	
	local ft = fadeTimer:new()
	ft.fader = fader
	ft.ticks = ticks
	ft.period = period
	
	table.insert(fadeTimers.all, ft)
	
	return ft
	
end
		
fadeTimer = {}
function fadeTimer:new()
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
end

function fadeTimer:trigger()
	Player.me:fade_screen(self.fader)
end