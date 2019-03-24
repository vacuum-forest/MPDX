Persistence = {}

function initPersistence(restoring_game)

	if restoring_game then
		Persistence.restored_from_saved = Game.restore_saved()
		Persistence.restored_from_passed = false
	else
		Persistence.restored_from_passed = Game.restore_passed()
		Persistence.restored_from_saved = false
	end

	if Game._persistences[Level.index] then

	else
		Game._persistences[Level.index] = {}
	end

end


function restorePersistence()

	if Persistence.restored_from_passed or Persistence.restored_from_saved then
		
		Persistence.doors.restore()
		Persistence.elevators.restore()
	
	end
	
end

function cleanupPersistence()

	Persistence.doors.store()
	Persistence.elevators.store()
	
end



-- Doors

Persistence.doors = {}

function Persistence.doors.store()

	Game._persistences[Level.index].doors = {}

	for n = 1, # Doors, 1 do
		
		if not Doors[n].closeDelay then

			local state = {["k"] = n, ["v"] = Doors[n].state}
			table.insert(Game._persistences[Level.index].doors, state)
			
		end

	end
	
end

function Persistence.doors.restore()

	if not Game._persistences[Level.index].doors then
		return
	end

	for n = 1, # Game._persistences[Level.index].doors, 1 do
		
		local s = Game._persistences[Level.index].doors[n]
		
		if Doors[s.k].state ~= s.v then
		
			Doors[s.k]:setState(s.v)
			
		end
		
	end
	
end

-- Elevators

Persistence.elevators = {}

function Persistence.elevators.store()

	Game._persistences.elevators = {}

	for n = 1, # Elevators, 1 do
		
		Game._persistences.elevators[n] = {}
		Game._persistences.elevators[n].status = Elevators[n].status
		Game._persistences.elevators[n].currentFloor = Elevators[n].currentFloor
		Game._persistences.elevators[n].desiredFloor = Elevators[n].desiredFloor
		Game._persistences.elevators[n].interval = Elevators[n].interval
	
	end
	
end

function Persistence.elevators.restore()
	
	if not Game._persistences.elevators then
		return
	end
	
	for n = 1, # Game._persistences.elevators, 1 do
		
		Elevators[n].currentFloor = Game._persistences.elevators[n].currentFloor
		Elevators[n].desiredFloor = Game._persistences.elevators[n].desiredFloor
		Elevators[n].interval = Game._persistences.elevators[n].interval
		Elevators[n].status = Game._persistences.elevators[n].status
		
		if Elevators[n].status == "active" then
	
			local action = function()
				Elevators[n].polygon:play_sound(100)
			end
	
			Elevators[n].noise = createTimer(20, true, action)
			
		end
		
	end
	
end
