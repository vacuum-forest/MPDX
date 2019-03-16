Elevators = {}

function initElevators()

	Elevators[1] = {}
	Elevators[1].id = "elevator 1"
	Elevators[1].status = "inactive"
	Elevators[1].currentFloor = 3		-- Default starting position (new game)
	Elevators[1].desiredFloor = nil
	Elevators[1].interval = nil
	Elevators[1].door = nil
	Elevators[1].polygon = nil
	Elevators[1].facing = 90
	Elevators[1].noise = nil

	Elevators[1].floors = {}
	Elevators[1].floors[1] = {}
	Elevators[1].floors[1].name = "2F"
	Elevators[1].floors[1].level = 99
	Elevators[1].floors[1].keys = nil

	Elevators[1].floors[2] = {}
	Elevators[1].floors[2].name = "Lobby"
	Elevators[1].floors[2].level = 0
	Elevators[1].floors[2].keys = nil

	Elevators[1].floors[3] = {}
	Elevators[1].floors[3].name = "B1"
	Elevators[1].floors[3].level = 6
	Elevators[1].floors[3].keys = nil

	Elevators[1].floors[4] = {}
	Elevators[1].floors[4].name = "B2"
	Elevators[1].floors[4].level = 99
	Elevators[1].floors[4].keys = nil

	setmetatable(Elevators[1], {__index = Elevators})

	Elevators[2] = {}
	Elevators[2].id = "elevator 2"
	Elevators[2].status = "inactive"
	Elevators[2].currentFloor = 3		
	Elevators[2].desiredFloor = nil
	Elevators[2].interval = nil
	Elevators[2].door = nil
	Elevators[2].polygon = nil
	Elevators[2].facing = 90
	Elevators[2].noise = nil

	Elevators[2].floors = {}
	Elevators[2].floors[1] = {}
	Elevators[2].floors[1].name = "2F"
	Elevators[2].floors[1].level = 99
	Elevators[2].floors[1].keys = nil

	Elevators[2].floors[2] = {}
	Elevators[2].floors[2].name = "Lobby"
	Elevators[2].floors[2].level = 0
	Elevators[2].floors[2].keys = nil

	Elevators[2].floors[3] = {}
	Elevators[2].floors[3].name = "B1"
	Elevators[2].floors[3].level = 6
	Elevators[2].floors[3].keys = nil

	setmetatable(Elevators[2], {__index = Elevators})

	if Game._elevators then
		restoreElevatorStates()
	end

	for i = 1, #Elevators, 1 do

		local e = Elevators[i]
		
		for p in Polygons() do
			if p.type == "glue" then
				local note = getAnnotationContents("Elevator", p, nil)
				if note then
					if tonumber(note[2]) == i then
						e.polygon = p
						e.facing = tonumber(note[3])
					break
					end
				end
			end
		end
		
	end

end

function Elevators:summon()

	Players.print("Summoning!")
	Players.print("CFloor: " .. tostring(self.currentFloor))
	Players.print("DFloor: " .. tostring(self.desiredFloor))

	if self.status == "active" then
		return
	end
	
	for i = 1, #self.floors, 1 do
		if self.floors[i].level == Level.index then
			self.desiredFloor = i
			break
		end
	end
	
	if not self.desiredFloor then
		return
	end
	
	if self.desiredFloor == self.currentFloor then
		
		local action = function() 
			self.door:openSesame() 
		end
		
		createTimer(15, false, action)
		
		return
	end
	
	self.interval = math.abs(self.desiredFloor - self.currentFloor) * 300
	
	self.polygon:play_sound(27)
	
	local action = function()
		self.polygon:play_sound(100)
	end
	
	self.noise = createTimer(20, true, action)
	
	self.status = "active"
	
end

function Elevators:dispatch(floor)
	
	if self.status == "active" then
		return
	end
	
	if floor == self.currentFloor then
		return
	end
	
	self.desiredFloor = floor
	self.interval = math.abs(self.desiredFloor - self.currentFloor) * 300
	Players.print(self.interval)
	
	self.status = "active"
	
	local target = {}
	target.level = self.floors[self.desiredFloor].level
	target.id = self.id
	
	storeElevatorData()
	
	levelTransition(target)
	
end

function Elevators:interaction()

	self.door:closeSesame()
	
	local action = function()
		
		self:dispatch(3)
		
	end
	
	createTimer(90, false, action)

end

function Elevators:hasLevel(level)

	for i = 1, #self.floors, 1 do
		if self.floors[i].level == level then
			return true
		end
	end
	
	return
	
end

function elevatorsIdleUpkeep()

	for i = 1, #Elevators, 1 do

		local e = Elevators[i]

		if e.status == "active" then
	
			if not e.interval then
				e.status = "inactive"
				return
			end
	
			e.interval = e.interval - 1
	
			if e.interval == 30 then
				e.noise:kill()
				e.polygon:play_sound(28)
			end
	
			if e.interval <= 0 then
		
				e.currentFloor = e.desiredFloor
				e.desiredFloor = nil
				e.interval = nil
				e.door:openSesame()
		
			end
	
		end

	end
	
end

function storeElevatorData()

	Game._elevators = Elevators
	
end

function restoreElevatorStates()
	
	for i = 1, #Game._elevators, 1 do
		
		local e = Game._elevators[i]
		
		Elevators[i].status = e.status
		Elevators[i].currentFloor = e.currentFloor
		Elevators[i].desiredFloor = e.desiredFloor
		Elevators[i].interval = e.interval
		
	end
	
end