--[[	Scenery.lua (MPDX) by Ku-rin
		
		This script handles scenery type definitions and functions specific to scenery objects.
	
]]

function initScenery()

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
	SceneryTypes[37].mnemonic = "turret base"
	SceneryTypes[28].mnemonic = "payphone"
	SceneryTypes[29].mnemonic = "table phone"
	SceneryTypes[34].mnemonic = "sweeper body"
	SceneryTypes[35].mnemonic = "sweeper brush"
	SceneryTypes[42].mnemonic = "ladder 1"
	SceneryTypes[44].mnemonic = "door swing hatch"
	SceneryTypes[45].mnemonic = "frame swing hatch"
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
	
	for s in Scenery() do
		if s.type._autocenter then
			s:position(s.polygon.x, s.polygon.y, s.polygon.z, s.polygon)
		end
	end
	
end