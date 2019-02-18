Triggers = {}

CollectionsUsed = { 25 } -- Damaged goods collection found here!

function initSceneryTypes()

	SceneryTypes[0].mnemonic = "door placeholder"
	SceneryTypes[2].mnemonic = "door collision cylinder"
	SceneryTypes[3].mnemonic = "door swing 1a l"
	SceneryTypes[4].mnemonic = "door swing 1b l"
	SceneryTypes[5].mnemonic = "door swing 1c l"
	SceneryTypes[6].mnemonic = "terminal 1"
	SceneryTypes[7].mnemonic = "terminal 2"
	SceneryTypes[8].mnemonic = "frame swing single"
	SceneryTypes[9].mnemonic = "frame swing double"
	SceneryTypes[10].mnemonic = "frame slide auto"
	SceneryTypes[11].mnemonic = "frame slide manual"
	SceneryTypes[15].mnemonic = "camera panel"
	SceneryTypes[17].mnemonic = "door swing 1a r"
	SceneryTypes[18].mnemonic = "door swing 1b r"
	SceneryTypes[19].mnemonic = "door swing 1c r"
	SceneryTypes[20].mnemonic = "door slide auto"
	SceneryTypes[21].mnemonic = "door slide manual"
	SceneryTypes[22].mnemonic = "door elevator"
	SceneryTypes[27].mnemonic = "window 1"
	SceneryTypes[28].mnemonic = "payphone"
	SceneryTypes[29].mnemonic = "table phone"
	SceneryTypes[34].mnemonic = "sweeper body"
	SceneryTypes[35].mnemonic = "sweeper brush"
	SceneryTypes[52].mnemonic = "garage baluster"
	SceneryTypes[55].mnemonic = "camera panel inactive"
	SceneryTypes[56].mnemonic = "terminal 1 inactive"
	SceneryTypes[57].mnemonic = "terminal 2 inactive"
	SceneryTypes[58].mnemonic = "camera panel damaged"
	SceneryTypes[59].mnemonic = "terminal 1 damaged"
	SceneryTypes[60].mnemonic = "terminal 2 damaged"

	SceneryTypes[0]._kind = "token"
	SceneryTypes[2]._kind = "physics"
	SceneryTypes[3]._kind = "door"
	SceneryTypes[4]._kind = "door"
	SceneryTypes[5]._kind = "door"
	SceneryTypes[6]._kind = "terminal"
	SceneryTypes[7]._kind = "terminal"
	SceneryTypes[8]._kind = "doorframe"
	SceneryTypes[9]._kind = "doorframe"
	SceneryTypes[10]._kind = "doorframe"
	SceneryTypes[11]._kind = "doorframe"
	SceneryTypes[15]._kind = "panel"
	SceneryTypes[17]._kind = "door"
	SceneryTypes[18]._kind = "door"
	SceneryTypes[19]._kind = "door"
	SceneryTypes[20]._kind = "door"
	SceneryTypes[21]._kind = "door"
	SceneryTypes[22]._kind = "door"
	SceneryTypes[27]._kind = "decoration"
	SceneryTypes[28]._kind = "savepoint"
	SceneryTypes[29]._kind = "savepoint"
	SceneryTypes[34]._kind = "monster"
	SceneryTypes[35]._kind = "monster part"
	SceneryTypes[52]._kind = "scenery"

	SceneryTypes[0]._autocenter = true
	SceneryTypes[27]._autocenter = true
	
end

function initScenery()
	for s in Scenery() do
		if s.type._autocenter then
			s:position(s.polygon.x, s.polygon.y, s.polygon.z, s.polygon)
		end
	end
end


function Triggers.init(restoring_game)
	
	if restoring_game == true then
		Game.restore_saved()
		isSavedGame = true
	else
		Game.restore_passed()
		isSavedGame = false
	end
	
	Sounds["spht door opening"].mnemonic = "door slide open"
	Sounds["spht door closing"].mnemonic = "door slide close"
	Sounds["switch off"].mnemonic = "door swing open"
	Sounds["drone dying"].mnemonic = "door swing close"
	
	-- Load up Lua modules
	
	--functions_debug = loadfile("MPDX/Data/Lua/hoihoi.lua")			-- Debugging, logging
	--functions_debug()
	
	functions_helpers = loadfile("MPDX/Data/Lua/helpers.lua")		-- Assorted Hors d'oeuvres, helper functions
	functions_helpers()
	
	functions_faders = loadfile("MPDX/Data/Lua/faders.lua")			-- Faders
	functions_faders()
	
	functions_player = loadfile("MPDX/Data/Lua/player.lua")			-- Player functions, upkeep
	functions_player()
	
	functions_transit = loadfile("MPDX/Data/Lua/transit.lua")		-- Intralevel transit
	functions_transit()
	
	--[[
	functions_inventory = loadfile("MPDX/Data/Lua/inventory.lua")
	functions_inventory()
	--]]
	
	functions_cameras = loadfile("MPDX/Data/Lua/cameras.lua")		-- Cameras
	functions_cameras()

	functions_doors = loadfile("MPDX/Data/Lua/doors.lua")			-- Doors
	functions_doors()
	
	functions_keys = loadfile("MPDX/Data/Lua/keys.lua")				-- Keys and other access control
	functions_keys()
	
	functions_terminals = loadfile("MPDX/Data/Lua/terminals.lua")	-- Terminals
	functions_terminals()
	
	functions_switches = loadfile("MPDX/Data/Lua/switches.lua")		-- Switches
	functions_switches()
	
	-- Initialize tables (in the proper order!)
	
	--initHoihoi()
	initFaders()
	initPlayer()
	initTransit()
	initSceneryTypes()
	initScenery()
	initCameras()
	initDoors()
	initKeys()
	initTerminals()
	initSwitches()
	--initInventory()
	
end

function Triggers.idle()
	
	fadersIdleUpkeep()
	
	playerIdleUpkeep()
	
	--[[
	HUDsend = io.open("hud.txt","w+")
	HUDsend:write(Player.mode .. "\n")
	HUDsend:write(Player.submode .. "\n")
	HUDsend:write(Player.serialParameters() .. "\n")
	HUDsend:write(Player.dPad.sig)
	HUDsend:close()]]
	
end

function Triggers.postidle()
	
	playerPostIdleUpkeep()
	camsIdleUpkeep()
	doorsIdleUpkeep()
	switchesIdleUpkeep()
	terminalsIdleUpkeep()
	
end

function Triggers.cleanup()

	--exitHoihoi()
	
end