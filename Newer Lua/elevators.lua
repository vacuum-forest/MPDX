ElevatorGlobal = {}

ElevatorGlobal["North"] = {
	["enable"] = true,
	["keys"] = nil,
	["floor"] = { ["initial"] = "Ground Floor" },
	["floors"] = {
		["Third Floor"] = {["keys"] = nil},
		["Second Floor"] = {["keys"] = nil},
		["Ground Floor"] = {["keys"] = nil},
		["Basement 1"] = {["keys"] = nil},
		["Basement 2"] = {["keys"] = nil}
	}
}

ElevatorGlobal["South"] = {
	["enable"] = true,
	["keys"] = nil,
	["floor"] = { ["initial"] = "Ground Floor" },
	["floors"] = {
		["Third Floor"] = {["keys"] = nil},
		["Second Floor"] = {["keys"] = nil},
		["Ground Floor"] = {["keys"] = nil}
	}
}

function initElevators()

	local elevatorQueue = findCommandAnnotations("Elevator")
	
	if not elevatorQueue then return end
	
	for k, v in pairs(elevatorQueue) do
	
		local data = processAnnotationCommand(v)
		
		local elevator = {}
		-- elevator.polygon = v.polygon
		-- TODO: Fix for room
		
		if # data.parameters == 1 then
			
			elevator.id = data.parameters[1]
			
		else
			
		end

	end

end
