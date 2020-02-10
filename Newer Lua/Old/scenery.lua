--[[	Scenery.lua (MPDX) by Ku-rin
		
		This script handles scenery type definitions and functions specific to scenery objects.
	
]]

function initScenery()

	SceneryTypes[1].mnemonic = "door collision cylinder"
	SceneryTypes[2].mnemonic = "doorframe single"
	SceneryTypes[3].mnemonic = "doorframe double"
	SceneryTypes[4].mnemonic = "doorframe toilet"
	SceneryTypes[5].mnemonic = "door toilet"
	SceneryTypes[6].mnemonic = "door elevator"
	
	SceneryTypes[7].mnemonic = "ladder 1"
	
	SceneryTypes[12].mnemonic = "qr placard"
	SceneryTypes[13].mnemonic = "door solid r"
	SceneryTypes[14].mnemonic = "door solid l"
	SceneryTypes[15].mnemonic = "door glass r"
	SceneryTypes[16].mnemonic = "door glass l"
	SceneryTypes[17].mnemonic = "handleset a r"
	SceneryTypes[18].mnemonic = "handleset a l"
	SceneryTypes[19].mnemonic = "handleset b r"
	SceneryTypes[20].mnemonic = "handleset b l"
	SceneryTypes[21].mnemonic = "handleset c r"
	SceneryTypes[22].mnemonic = "handleset c l"
	SceneryTypes[23].mnemonic = "handleset d r"
	SceneryTypes[24].mnemonic = "handleset d l"
	SceneryTypes[25].mnemonic = "doorframe automatic"
	SceneryTypes[26].mnemonic = "door automatic"
	

	SceneryTypes[0]._kind = "token"
	
	SceneryTypes[5]._kind = "door"
	
	SceneryTypes[12]._kind = "qr placard"
	
	SceneryTypes[13]._kind = "door"
	SceneryTypes[14]._kind = "door"
	SceneryTypes[15]._kind = "door"
	SceneryTypes[16]._kind = "door"
	SceneryTypes[17]._kind = "door"
	SceneryTypes[18]._kind = "door"
	SceneryTypes[19]._kind = "door"
	SceneryTypes[20]._kind = "door"
	SceneryTypes[21]._kind = "door"
	SceneryTypes[22]._kind = "door"
	SceneryTypes[23]._kind = "door"
	SceneryTypes[24]._kind = "door"
	SceneryTypes[25]._kind = "door"
	SceneryTypes[26]._kind = "door"
	
	SceneryTypes[43]._conveyable = true

	SceneryTypes[1]._kind = "physics"

	SceneryTypes[1]._autocenter = true
	
	for s in Scenery() do
		if s.type._autocenter then
			s:position(s.polygon.x, s.polygon.y, s.polygon.z, s.polygon)
		end
	end
	
end