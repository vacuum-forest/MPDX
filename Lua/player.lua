Player = {}

function initPlayer()
	
	Player.me = Players[0]
	
	Player.me.weapons.active = false
	Player.me.crosshairs.active = false
	
	Player.mode = "default"
	Player.submode = " "
	Player.dPad = {}
	
	Player.last = { x = 0, y = 0, z = 0 }
	Player.diff = { x = 0, y = 0, z = 0 }
	Player.velocity = { speed = 0, direction = 0}
	
	Player.freezeState = {}
	Player.isFrozen = false
	
	Player.camera = {}
	Player.camera.current = nil
	
	-- Set up player parameters...
	Player.parameters = {}

		-- Health
		Player.parameters.HP = {}
		Player.parameters.HP.max = 200000
		Player.parameters.HP.current = 200000
		Player.parameters.HP.target = 200000
		Player.parameters.HP.min = -10000
		Player.parameters.HP.offset = {}
		Player.parameters.HP.offset.base = 1
		Player.parameters.HP.offset.current = 1
		Player.parameters.HP.offset.restMod = 10
		Player.parameters.HP.scale = 1000
		Player.parameters.HP.maxHurtRate = -200
		Player.parameters.HP.maxHealRate = 1

		-- Vitality
		Player.parameters.Vit = {}
		Player.parameters.Vit.max = 100
		Player.parameters.Vit.current = 100
		Player.parameters.Vit.min = 0
		Player.parameters.Vit.offset = {}
		Player.parameters.Vit.offset.base = -1 / 108000
		Player.parameters.Vit.offset.current = -1 / 108000
		Player.parameters.Vit.offset.restMod = 0.5

		-- Stamina
		Player.parameters.Sta = {}
		Player.parameters.Sta.max = 100
		Player.parameters.Sta.current = 100
		Player.parameters.Sta.min = 0
		Player.parameters.Sta.offset = {}
		Player.parameters.Sta.offset.base = 0.1
		Player.parameters.Sta.offset.current = 0.1
		Player.parameters.Sta.offset.restMod = 5

		-- Exhaustion
		Player.parameters.Exh = {}
		Player.parameters.Exh.max = 100
		Player.parameters.Exh.current = 100
		Player.parameters.Exh.min = 0
		Player.parameters.Exh.offset = {}
		Player.parameters.Exh.offset.base = -0.001
		Player.parameters.Exh.offset.current = -0.001
		Player.parameters.Exh.offset.restMod = -10

		-- Carrying capacity (mass) in KG
		Player.parameters.mass = {}
		Player.parameters.mass.max = 30
		Player.parameters.mass.current = 0
		Player.parameters.mass.min = 0
		Player.parameters.mass.offset = {}
		Player.parameters.mass.offset.base = 0
		Player.parameters.mass.offset.current = 0
		Player.parameters.mass.offset.restMod = 0

		-- Carrying capacity (volume) in cc (1/1000 L, if you're carrying soup.)
		Player.parameters.volume = {}
		Player.parameters.volume.max = 1000
		Player.parameters.volume.current = 0
		Player.parameters.volume.min = 0
		Player.parameters.volume.offset = {}
		Player.parameters.volume.offset.base = 0
		Player.parameters.volume.offset.current = 0
		Player.parameters.volume.offset.restMod = 0
		
		Player.parameters.speed = {}
		Player.parameters.speed.runThreshold = 0.045 -- Remember you're looking at the total speed, not just forwards or sideways!
		Player.parameters.speed.offset = {}
		Player.parameters.speed.offset.base = 0
		Player.parameters.speed.offset.current = 0

	-- Set up player stats...
	Player.stats = {}

		Player.stats.STR = 10	-- Strength
		Player.stats.CON = 10	-- Constitution
		Player.stats.INT = 10	-- Intelligence
		Player.stats.DEX = 10	-- Dexterity
	
end

function Player.niteyNite()
	
	Player.me:fade_screen("cinematic fade out")
	Player.snoozeFade = fadeTimers:set("tint green", 10, 30)
	Player.freeze()
	Player.mode = "resting"
	
end

function Player.wakeUp()
	
	Player.snoozeFade.ticks = -1
	Player.me:fade_screen("cinematic fade in")
	Player.defrost()
	Player.mode = "default"
	
end

function Player.freeze()

	local state = {}
	state.x = Player.me.x
	state.y = Player.me.y
	state.z = Player.me.z
	state.u = Player.me.yaw
	state.v = Player.me.pitch
	state.w = Player.me.polygon
	Player.freezeState = state
	
	Player.me.weapons.active = false
	
	Player.isFrozen = true
	
end

function Player.frozen()
	
	Player.me:position(Player.freezeState.x, Player.freezeState.y, Player.freezeState.z, Player.freezeState.w)
    Player.me.external_velocity.i = 0
    Player.me.external_velocity.j = 0
    Player.me.external_velocity.k = 0
	Player.me.yaw = Player.freezeState.u
	Player.me.pitch = Player.freezeState.v
	
end

function Player.defrost()

	if Player.isFrozen then
	
		Player.me.weapons.active = true
		Player.isFrozen = false
		
	end
	
end

function playerPDamagedUpkeep(victim, aggressor_player, aggressor_monster, damage_type, damage_amount, projectile)

	if Player.mode ~= "default" then
		if Player.camera.current then
			Player.camera.current:stop()
		end
		if Player.me._termViewing then
			Player.me._termViewing:stop()
		end
		if Player.mode == "resting" then
			Player.wakeUp()
		end
	end
	
	if damage_amount * 1000 < Player.parameters.HP.target + 5000 then
		
		if Player.me.life > -10 then
			Player.me.life = Player.me.life + damage_amount
		end
		
		Player.parameters.HP.target = Player.parameters.HP.target - damage_amount * 1000
		
	else
		
		Player.parameters.HP.current = Player.parameters.HP.target - damage_amount * 1000
		
	end
	
		
end

function playerMKUpkeep(monster, aggressor_player, projectile)

	-- Put stuff for killing monsters in here.

end

function playerIdleUpkeep()

	Player.speedCheck()
	
	Player.updateParameters()

	if Player.me.action_flags.action_trigger then
		if Player.mode == "default" or Player.mode == "camera" then
			local o, x, y, z, polygon = Player.me:find_target()
			local distance = getDistance(x, y, z, Player.me)
			if distance <= 1 then
				if is_scenery(o) then
					if o._parent then
						o._parent:interaction()
					end
				end
			end
		elseif Player.mode == "resting" then
			Player.wakeUp()
		end
	end 
	
end

function playerPostIdleUpkeep()
	
	if Player.isFrozen then Player.frozen() end
	
end

function Player.speedCheck()

	Player.diff.x = Player.me.x - Player.last.x
	Player.diff.y = Player.me.y - Player.last.y
	Player.diff.z = Player.me.z - Player.last.z

	Player.last.x = Player.me.x
	Player.last.y = Player.me.y
	Player.last.z = Player.me.z
	
	Player.dPad.lat = getSign(Player.me.internal_velocity.forward)
	Player.dPad.lon = getSign(Player.me.internal_velocity.perpendicular)
	Player.dPad.sig = tostring(Player.dPad.lat) .. "," .. tostring(Player.dPad.lon)
	
	-- Get actual 2D velocity...
	Player.velocity.speed, Player.velocity.direction = cartToRad(Player.diff.x, Player.diff.y)
	
end

function Player.isRunning()

	local a = Player.me.internal_velocity.forward ~=0 or Player.me.internal_velocity.perpendicular ~= 0
	
	local b = Player.velocity.speed >= Player.parameters.speed.runThreshold
	
	local c = Player.mode == "default"
	
	local d = not Player.isFrozen
	
	if a and b and c and d then
		return false	--DEBUG
	else
		return false
	end
	
end

function Player.updateParameters()

	local HP = Player.parameters.HP
	local Vitality = Player.parameters.Vit
	local Stamina = Player.parameters.Sta
	local Exhaustion = Player.parameters.Exh
	local Mass = Player.parameters.mass
	local Volume = Player.parameters.volume
	
	if Player.me.dead then
		return
	end
	
	-- HP
	
	local HPdiff
	if HP.target < HP.current then 
		HPdiff = math.max(HP.maxHurtRate, (HP.target - HP.current) / 10)
		if Player.mode == "resting" then
			HPdiff = HPdiff / HP.offset.restMod
		end
	else
		HPdiff = math.min(HP.maxHealRate, HP.target - HP.current)
		if Player.mode == "resting" then
			HPdiff = HPdiff * HP.offset.restMod
		end
	end

	HP.current = HP.current + HPdiff
	
	if HP.current < HP.min then HP.current = HP.min end
	if HP.current > HP.max then HP.current = HP.max end
	
	HP.offset.current = HP.offset.base * 0.5 * (Vitality.current / Vitality.max + Exhaustion.current / Exhaustion.max)
	
	if Vitality.current == Vitality.min then 
		HP.offset.current = HP.offset.current - 0.5 
	end
	
	-- Vitality
	
	Vitality.offset.current = Vitality.offset.base + (Stamina.current - Stamina.max) * 0.0001 + (HP.current - HP.max) * 0.0000005
	
	-- Stamina
	
	Stamina.offset.current = Stamina.offset.base	
	
	if HP.current == HP.max and Vitality.current / Vitality.max > 0.75 and Exhaustion.current / Exhaustion.max > 0.75 then
		Stamina.offset.current = 2 * Stamina.offset.base
	end
		
	if HP.current / HP.max < 0.1 then
		Stamina.offset.current = Stamina.offset.current - 0.1
	end
	
	if Vitality.current == Vitality.min then
		Stamina.offset.current = Stamina.offset.current - 0.1
	end
	
	if Player.isRunning() then
		Stamina.offset.current = Stamina.offset.current - 1.25
	end
	
	-- Exhaustion
	
	Exhaustion.offset.current = Exhaustion.offset.base + (Stamina.current - Stamina.max) * 0.00005 + (HP.current - HP.max) * 0.0000001
	
	-- Apply offsets
	for _, i in pairs(Player.parameters) do
		if i.offset.restMod and Player.mode == "resting" then
			i.offset.current = i.offset.current * i.offset.restMod
		end
		if i == HP then
			i.target = i.target + i.offset.current
			if i.target > i.max then
				i.target = i.max
			elseif i.target < i.min then
				i.target = i.min
			end
		else
			if i.current then
				i.current = i.current + i.offset.current
				if i.current > i.max then
					i.current = i.max
				elseif i.current < i.min then
					i.current = i.min
				end
			end
		end
	end
	
	-- Adjust Speed
	
	if Player.parameters.Sta.current <= 50 then
		Player.parameters.speed.offset.current = Player.parameters.speed.offset.base - (0.005 * (50 - Player.parameters.Sta.current))
	else
		Player.parameters.speed.offset.current = Player.parameters.speed.offset.base
	end

	local speedMod = Player.parameters.speed.offset.current * Player.velocity.speed
	
	if Player.me.z - Player.me.polygon.floor.z < 0.125 then
		Player.me:accelerate(Player.velocity.direction, speedMod, 0)
	end
	
	-- Adjust Life
	
	Player.me.life = math.floor(HP.current / HP.scale)
	
	if Player.me.life < 0 then
		Player.me:damage(20, "hulk slap")
	end
	
end

function Player.serialParameters()
	
	local string = ""
	
	local name = { "HP", "Vit", "Sta", "Exh", "mass", "volume" } -- Only send these to the HUD script
	
	for i = 1, # name, 1 do
		string = string .. "," .. tostring(Player.parameters[name[i]].current) .. "," .. tostring(Player.parameters[name[i]].max)
	end
	
	return string.sub(string, 2)
	
end