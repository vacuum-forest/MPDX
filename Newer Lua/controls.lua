function initControls()

	Player.controlState = nil

	-- Control Assignments:
	--
	-- Each control is assigned a specific bitmask representing
	-- the combination of action triggers as specified in updateControls().
	--
	-- Each control has an action and exclusivity specified for a given
	-- context.
	--
	-- During Triggers.idle() each control is compared against the present
	-- sum of action triggers, as calculated in updateControls(). 
	-- If the control is exclusive, its value is XOR-ed against the sum, 
	-- otherwise it is AND-ed. Meaning, an exclusive control will only fire 
	-- its assigned action when it is the sole input present.
	-----------------------------------------------------------------------

	Control = {}
	
	Control.modifier = "modifier"

	Controls = {}
	
	Controls = {
		["modifier"] = { value = 64 },					-- Mic
		["action a"] = { value = 32 },					-- Action
		["action b"] = { value = 96 },					-- Action + Mic
		["cycle left a"] = { value = 16 },				-- Weapons Backward
		["cycle right a"] = { value = 8 },				-- Weapons Forward
		["cycle left b"] = { value = 80 },				-- Weapons Backward + Mic
		["cycle right b"] = { value = 72 },				-- Weapons Forward + Mic
		["trigger primary a"] = { value = 4 },			-- Left Trigger
		["trigger secondary a"] = { value = 2 },		-- Right Trigger
		["trigger primary b"] = { value = 68 },			-- Left Trigger + Mic
		["trigger secondary b"] = { value = 66 },		-- Right Trigger + Mic
		["select a"] = { value = 1 },					-- Map
		["select b"] = { value = 65 }					-- Map + Mic
	}
	
	Contexts = {}
	Contexts["default"] = {
	
		["modifier"] = {
			["action"] = nil,
			["exclusive"] = true
		},
		
		["action a"] = {
			["action"] = Player.actions.defaultInteraction,
			["exclusive"] = false
		},
		
		["action b"] = {
			["action"] = Player.actions.examineSide,
			["exclusive"] = false
		},
		
		["cycle left a"] = {
			["action"] = function()
				Players.print("cycle left a")
			end,
			["exclusive"] = false
		},
		
		["cycle right a"] = {
			["action"] = function()
				Players.print("cycle right a")
			end,
			["exclusive"] = false
		},
		
		["cycle left b"] = {
			["action"] = function()
				Players.print("cycle left b")
			end,
			["exclusive"] = false
		},
		
		["cycle right b"] = {
			["action"] = function()
				Players.print("cycle right b")
			end,
			["exclusive"] = false
		},
		
		["trigger primary a"] = {
			["action"] = function()
				Players.print("trigger primary a")
			end,
			["exclusive"] = false
		},
		
		["trigger secondary a"] = {
			["action"] = function()
				Players.print("trigger secondary a")
			end,
			["exclusive"] = false
		},
		
		["trigger primary b"] = {
			["action"] = function()
				Players.print("trigger primary b")
			end,
			["exclusive"] = false
		},
		
		["trigger secondary b"] = {
			["action"] = function()
				Players.print("trigger secondary b")
			end,
			["exclusive"] = false
		},
		
		["select a"] = {
			["action"] = function()
				Players.print("select a")
			end,
			["exclusive"] = false
		},
		
		["select b"] = {
			["action"] = function()
				Players.print("select b")
			end,
			["exclusive"] = false
		}
	
	}
	
	for k, v in pairs(Controls) do
		
		local currentControl = k
		
		Controls[currentControl].contexts = {}
		
		for i, j in pairs(Contexts) do
			
			local activeContext = i
			Controls[currentControl].contexts[activeContext] = Contexts[activeContext][currentControl]
			
		end
	end

end

function updateControls()
	
	local flags = {
		{input = Players[0].action_flags.microphone_button, value = 64},
		{input = Players[0].action_flags.action_trigger, value = 32},
		{input = Players[0].action_flags.cycle_weapons_backward, value = 16},
		{input = Players[0].action_flags.cycle_weapons_forward, value = 8},
		{input = Players[0].action_flags.left_trigger, value = 4},
		{input = Players[0].action_flags.right_trigger, value = 2},
		{input = Players[0].action_flags.toggle_map, value = 1}
	}
	
	local output = 0
	
	for k, v in ipairs(flags) do
		
		if v.input then
			output = output + v.value
		end
	
	end
	
	Player.controlState = output
	
	for k, v in pairs(Controls) do
		
		local control = v
		local modifier = Controls[Control.modifier]
		local skip = false
		local hit = false
	
		-- Inhibit unmodified controls when modifier is active:
		if Player.controlState >= modifier.value then
			if control.value <= modifier.value then 
				skip = true
			end
		end
		
		if not skip then
			
			if control.contexts[Player.mode].exclusive then
				hit = bXOR(Player.controlState, control.value) == 0
			else
				hit = bAND(Player.controlState, control.value) == control.value
			end
			
			if hit then
				control.contexts[Player.mode].action()
			end
			
		end
	end
end