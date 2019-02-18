function initKeys()
	
	Players.print("Initializing Keys...")

	Keys = {}
	
	local sourceTable = io.open("MPDX/Data/Tables/keys.csv", "r")
	
	for i = 0, 2, 1 do
		
		local filter = filterCSVLine(sourceTable:read())
		
		local set = {}
		
		local name = filter[1]
		
		Keys[name] = {}
		
		set.owner = filter[2] or "nobody"
		set.description = filter[3] or "It's a key."
		
		Keys[name] = set
		
	end
	
	sourceTable:close()
	
end