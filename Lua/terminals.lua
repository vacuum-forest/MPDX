function initTerminals()

	TermTypes = {}
	
	TermTypes["large terminal"] = {}
	TermTypes["large terminal"].object = {}
	TermTypes["large terminal"].object.active = "terminal 1"
	TermTypes["large terminal"].object.inactive = "terminal 1 inactive"
	TermTypes["large terminal"].object.locked = "terminal 1"
	TermTypes["large terminal"].object.dead = "terminal 1 damaged"
	
	TermTypes["small terminal"] = {}
	TermTypes["small terminal"].object = {}
	TermTypes["small terminal"].object.active = "terminal 2"
	TermTypes["small terminal"].object.inactive = "terminal 2 inactive"
	TermTypes["small terminal"].object.locked = "terminal 2"
	TermTypes["small terminal"].object.dead = "terminal 2 damaged"
	
	setUpTerminals()
	
end

Terms = {}
Terms.list = {}

function installTerminal(id, type, status, x, y, height, facing, polygon)
	
	local term = Terms:new()
	
	-- Set basic parameters
	
	term.id = id
	term.type = TermTypes[type]
	term.status = status
	term.facing = facing
	term.height = height + polygon.floor.height
	term.polygon = polygon
	
	term.object = Scenery.new(x, y, term.height, term.polygon, TermTypes[type].object[status])
	term.object:position(x, y, term.height, term.polygon)
	term.object.facing = term.facing
	term.object._parent = term
	
	table.insert(Terms.list, term)
	
end

function Terms:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Terms:interaction()

	if self.status == "active" then

		
	
	elseif self.status == "dead" then
		
		Players.print("This terminal looks like it's been damaged. It doesn't seem to work at all.")
	
	elseif self.status == "locked" then
		
		Players.print("This terminal is locked, you can't access it.")
		
	else
		
		Players.print("This terminal doesn't seem to be active.")
	
	end
	
end


function Terms:repair()

	if self.status == "dead" then
		Players.print("I can fix it!")
		--Do repair shit here
		self:changeStatus(self.lastLiveState)
	end
	
end


function Terms:changeStatus(newState)

	if newState == "dead" then
		self.lastLiveState = self.status
	end

	self.object = swapScenery(self.object, self.type.object[newState])
	self.status = newState
	
end


function setUpTerminals()

	local note = {}

	for a in Annotations() do
	
		note = filterCSVLine(a.text)
		
		if note[1] == "Terminal" then
			
			local t = {}
			t.id = Terminals[tonumber(note[2])]
			t.type = note[3]
			t.active = note[4] -- active, inactive, or dead.
			t.height = tonumber(note[5])
			t.facing = tonumber(note[6])
			t.polygon = a.polygon
			
			installTerminal(t.id, t.type, t.active, a.x, a.y, t.height, t.facing, a.polygon)
			
		end
		
	end
	
end

function terminalsIdleUpkeep()

	for i = 1, # Terms.list, 1 do
		if Terms.list[i].object.damaged then
			Terms.list[i]:changeStatus("dead")
		end
	end
	
end