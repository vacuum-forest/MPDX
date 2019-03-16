Persistence = {}

Game._Memories = {}

function initPersistence(restoring_game)

	if restoring_game then
		Persistence.restored_from_saved = Game.restore_saved()
		Persistence.restored_from_passed = false
	else
		Persistence.restored_from_passed = Game.restore_passed()
		Persistence.restored_from_saved = false
	end

end

function cleanupPersistence()

	
	
end

Memories = {}

function Memories:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end