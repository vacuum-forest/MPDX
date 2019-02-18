--[[ 

hoihoi.lua
by Kuu-rin (2019)

This script contains debugging functions, including logging and display for various tables.

	jot(string)
	Write string to debugMPDX.txt, prefaced with ticks elapsed, terminates with line break (saved at end of game)

	dumpScenery()
	Lists all scenery objects in the map with index, type, polygon, and position in sceneryDump.txt

--]]

function initHoihoi()

	oopsFile = io.open("debugMPDX.txt", "w")

end

function exitHoihoi()

	oopsFile:close()
	
end

function logWrite(s)

	oopsFile:write(tostring(Game.ticks), " ", s, "\n")

end

function dumpScenery()

	local dump = io.open("dumpScenery.txt", "w")
	
	for s in Scenery() do
	
		dump:write(tostring(s.index), " ", tostring(s.type), " poly:" , tostring(s.polygon), " x:", tostring(s.x), " y:", tostring(s.y), " z:", tostring(s.z), "\n")
		
	end
	
	dump:close()
	
end
