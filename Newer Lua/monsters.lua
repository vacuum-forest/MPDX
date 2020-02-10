function initMonsters()

	MonsterClasses["tick"].mnemonic = "smartvac"
	MonsterClasses["smartvac"]._hackable = true
	MonsterTypes["minor tick"].mnemonic = "docile smartvac"
	MonsterTypes["major tick"].mnemonic = "corrupt smartvac"
	MonsterTypes["kamikaze tick"].mnemonic = "hacked smartvac"
	MonsterTypes["hacked smartvac"]._hacked = true

	MonsterClasses["compiler"].mnemonic = "dalek"
	MonsterClasses["dalek"]._hackable = false
	MonsterTypes["minor compiler"].mnemonic = "benign dalek"
	MonsterTypes["major compiler"].mnemonic = "taser dalek"
	MonsterTypes["minor invisible compiler"].mnemonic = "dart dalek"
	MonsterTypes["major invisible compiler"].mnemonic = "suicide dalek"

	MonsterClasses["bob"].mnemonic = "turret"
	MonsterClasses["turret"]._hackable = false
	MonsterTypes["green bob"].mnemonic = "camera turret"
	MonsterTypes["blue bob"].mnemonic = "dart turret"
	MonsterTypes["security bob"].mnemonic = "gun turret"
	MonsterTypes["explodabob"].mnemonic = "death turret"
	
	MonsterTypes["tiny yeti"].mnemonic = "door daemon"
	
	for m in MonsterStarts() do 
		
		-- Add bases for turrets
		if m.type.class == "turret" then
			local turretMount = Scenery.new(m.x, m.y, m.polygon.ceiling.z - m.polygon.z, m.polygon, "turret base")
		end
		
	end
	
end

function monstersIdleUpkeep()
	
	for m in Monsters() do

		if m.type.class == "smartvac" then
			
			if m.action == "dying hard" and not m._blewUp then
				Players.print("BOOM")
				Effects.new(m.x,m.y,m.z,m.polygon, "rocket explosion")
				m._blewUp = true
			end
		
		elseif m.type == "door daemon" then
			
			if tickMod(15) and m._owner.enable then
				local infrared = Projectiles.new(m.x, m.y, m.z - 0.1, m.polygon, "door daemon pulse")
				infrared.pitch = -90
				infrared.yaw = 0
				infrared.owner = m
			end
				
		end

	end
	
end