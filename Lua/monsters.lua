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
		if m.type.class == "turret" then
			local turretMount = Scenery.new(m.x, m.y, m.polygon.ceiling.z - m.polygon.z, m.polygon, "turret base")
		end
	end
	
	for m in Monsters() do
		if m.type == "minor cyborg" then
		
			m._brushes = {}
			m._brushes.parent = m
			m._brushes.left = Scenery.new(m.x, m.y, m.z, m.polygon, "water alien supply can")
			m._brushes.right = Scenery.new(m.x, m.y, m.z, m.polygon, "water alien supply can")
			
		end
	end
	
end

function monstersIdleUpkeep()
	
	for m in Monsters() do

		if m.type == "minor cyborg" then
		
			spinBrushes(m._brushes)
			
		end

		if m.type.class == "smartvac" then
			
			if m.action == "dying hard" and not m._blewUp then
				Players.print("BOOM")
				Effects.new(m.x,m.y,m.z,m.polygon, "rocket explosion")
				m._blewUp = true
			end
				
		end

	end
	
end

function spinBrushes(brushes)

	local angle = 38.66
	local radius = 0.640312
	
	local px = brushes.parent.x
	local py = brushes.parent.y
	local pz = brushes.parent.z
	local facing = brushes.parent.facing
	
	local la = normalizeAngle(facing - angle)
	local ra = normalizeAngle(facing + angle)
	
	local lx, ly = radToCart(la, radius)
	local rx, ry = radToCart(ra, radius)
	
	for p in Polygons() do
		if p:contains(lx+px, ly+py) then
			brushes.left:position(lx+px, ly+py, pz, p)
			break
		end
	end
	
	for p in Polygons() do
		if p:contains(rx+px, ry+py) then
			brushes.right:position(rx+px, ry+py, pz, p)
			break
		end
	end

	brushes.left.facing = (brushes.left.facing - 47) % 360
	brushes.right.facing = (brushes.right.facing + 47) % 360
	
end