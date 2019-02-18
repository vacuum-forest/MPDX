function initFaders()

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