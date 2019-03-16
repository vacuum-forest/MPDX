--[[	Keys.lua (MPDX) by Ku-rin
		
		This script handles keys used to control access to doors and other interactables.
	
]]

Keys = {}

function initKeys()
	
	if not Player.me._keys then
		
		Player.me._keys = {}
		
	end
	
end

function playerHasKey(key)

	local found = false

	for k,v in ipairs(Player.me._keys) do
		
		if v == key then
			
			found = true
			break
			
		end
		
	end
	
	return found
	
end

