--[[	World.lua (MPDX) by Ku-rin
	
]]

-- Level Settings
-----------------------------------------------------------

Levels = {
	["Ground Floor"] = {
		["index"] = 0,
		["elevation"] = 0
	},
	["Ground Floor Interior"] = {
		["index"] = 1
	},
	["Basement 1"] = {
		["index"] = 2,
		["elevation"] = -1
	},
	["Stairwell"] = {
		["index"] = 3
	}
}



-- Mnemonics
-----------------------------------------------------------

-- Shots
ProjectileTypes["yeti"].mnemonic = "door daemon pulse"


-- Damage
DamageTypes["teleporter"].mnemonic = "sensor"


-- Sounds
Sounds["spht door opening"].mnemonic = "door slide open"
Sounds["spht door closing"].mnemonic = "door slide close"
Sounds["switch off"].mnemonic = "door swing open"
Sounds["drone dying"].mnemonic = "door swing close"


-- Scenery
SceneryTypes[28].mnemonic = "door collision cylinder"
SceneryTypes[29].mnemonic = "quarter collision cylinder"
SceneryTypes[30].mnemonic = "half collision cylinder"

SceneryTypes[39].mnemonic = "qr placard"

SceneryTypes[40].mnemonic = "ladder"

SceneryTypes[42].mnemonic = "handleset a r"
SceneryTypes[43].mnemonic = "handleset a l"
SceneryTypes[44].mnemonic = "handleset b r"
SceneryTypes[45].mnemonic = "handleset b l"
SceneryTypes[46].mnemonic = "handleset c r"
SceneryTypes[47].mnemonic = "handleset c l"
SceneryTypes[48].mnemonic = "handleset d r"
SceneryTypes[49].mnemonic = "handleset d l"

SceneryTypes[50].mnemonic = "doorframe single"
SceneryTypes[51].mnemonic = "doorframe double"
SceneryTypes[52].mnemonic = "doorframe toilet"
SceneryTypes[53].mnemonic = "doorframe automatic"

SceneryTypes[54].mnemonic = "door toilet"
SceneryTypes[55].mnemonic = "door automatic"
SceneryTypes[56].mnemonic = "door elevator"
SceneryTypes[57].mnemonic = "door solid r"
SceneryTypes[58].mnemonic = "door solid l"
SceneryTypes[59].mnemonic = "door glass r"
SceneryTypes[60].mnemonic = "door glass l"


function initWorld()

	
end