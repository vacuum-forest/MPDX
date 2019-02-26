Triggers = {}

if # Media > 0 then
	CollectionsUsed = { 11, 21, 23, 24, 25 }
else
	CollectionsUsed = { 11, 23, 24, 25 }
end

Game.proper_item_accounting = true

function Triggers.init(restoring_game)
	
	-- Push a global here so we can do stuff elsewhere...
	if restoring_game == true then
		Game.restore_saved()
		isSavedGame = true
	else
		Game.restore_passed()
		isSavedGame = false
	end
	
	-- These are just fuzz, TBR...
	
	Sounds["spht door opening"].mnemonic = "door slide open"
	Sounds["spht door closing"].mnemonic = "door slide close"
	Sounds["switch off"].mnemonic = "door swing open"
	Sounds["drone dying"].mnemonic = "door swing close"
	
	DamageTypes["teleporter"].mnemonic = "sensor"
	
	ProjectileTypes["yeti"].mnemonic = "sensor pulse"
	ProjectileTypes["minor hummer"].mnemonic = "camera flash"
	
	-- Load up Lua modules
	
	functions_scenery = loadfile("MPDX/Data/Lua/scenery.lua")		-- Scenery
	functions_scenery()
	
	functions_helpers = loadfile("MPDX/Data/Lua/helpers.lua")		-- Assorted Hors d'oeuvres, helper functions
	functions_helpers()
	
	functions_faders = loadfile("MPDX/Data/Lua/faders.lua")			-- Faders
	functions_faders()
	
	functions_player = loadfile("MPDX/Data/Lua/player.lua")			-- Player functions, upkeep
	functions_player()
	
	functions_transit = loadfile("MPDX/Data/Lua/transit.lua")		-- Intralevel transit
	functions_transit()
	
	functions_doors = loadfile("MPDX/Data/Lua/doors.lua")			-- Doors
	functions_doors()
	
	functions_monsters = loadfile("MPDX/Data/Lua/monsters.lua")		-- Monsters
	functions_monsters()
	
	functions_cameras = loadfile("MPDX/Data/Lua/cameras.lua")		-- Cameras
	functions_cameras()
	
	functions_keys = loadfile("MPDX/Data/Lua/keys.lua")				-- Keys and other access control
	functions_keys()
	
	functions_terminals = loadfile("MPDX/Data/Lua/terminals.lua")	-- Terminals
	functions_terminals()
	
	functions_panels = loadfile("MPDX/Data/Lua/panels.lua")		-- Switches
	functions_panels()
	
	functions_motions = loadfile("MPDX/Data/Lua/motions.lua")		-- Motions
	functions_motions()
	
	functions_features = loadfile("MPDX/Data/Lua/features.lua")		-- Features
	functions_features()
	
	functions_medias = loadfile("MPDX/Data/Lua/medias.lua")		-- Media
	functions_medias()
	
	-- Initialize tables (in the proper order!)
	
	initScenery()
	initFaders()
	initPlayer()
	initKeys()
	initTransit()
	initScenery()
	initMonsters()
	initDoors()
	initCameras()
	initTerminals()
	initPanels()
	initFeatures()
	initMedias()
	
end



function Triggers.projectile_detonated(type, owner, polygon, x, y, z)
	
	Players.print("Detonation: " .. tostring(type))
	
end



function Triggers.monster_damaged(monster, aggressor_monster, damage_type, damage_amount, projectile)

	doorsMDamagedUpkeep(aggressor_monster, damage_type)
	
end



function Triggers.player_damaged(victim, aggressor_player, aggressor_monster, damage_type, damage_amount, projectile)
	
	Players.print("Player hit: " .. tostring(damage_type))
	playerPDamagedUpkeep(victim, aggressor_player, aggressor_monster, damage_type, damage_amount, projectile)
	doorsPDamagedUpkeep(aggressor_monster, damage_type)
	
end



function Triggers.idle()
	
	fadersIdleUpkeep()
	playerIdleUpkeep()
	monstersIdleUpkeep()
	mediasIdleUpkeep()
	featuresIdleUpkeep()
	
end



function Triggers.postidle()
	
	playerPostIdleUpkeep()
	camsIdleUpkeep()
	doorsIdleUpkeep()
	panelsIdleUpkeep()
	terminalsIdleUpkeep()
	
end

function Triggers.cleanup()

	
end