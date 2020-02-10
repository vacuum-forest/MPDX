--[[	Keys.lua (MPDX) by Ku-rin
		
		This script handles keys used to control access to doors and other interactables.
	
]]
function initKeys()
	
	local keyQueue = findCommandAnnotations("Key")
	
	if not keyQueue then return end
	
	for k, v in pairs(keyQueue) do

		local data = processAnnotationCommand(v)
		
		local key = {}
		
		key.id = data.parameters[1]
		key.x = v.x
		key.y = v.y
		key.z = v.polygon.z
		key.polygon = v.polygon
		
		createPhysicalKey(key)
			
	end
	
end

Key = {}

Keys = {}

Keys.world = {}
Keys.level = {}
Keys.player = {}

function Key:new(o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end

function createPhysicalKey(parameters)

	local key = Key:new(parameters)
	
	key.object = Items.new(key.x, key.y, key.z, key.polygon, "key")
	key.object:position(key.x, key.y, key.z, key.polygon)
	key.object._owner = key
	
	table.insert(Keys.level, key)
	
end

function Key:acquire()
	
	moveKey(self.id, Keys.level, Keys.player)
	
end

function Key:drop()
	
	self.x = Players[0].x
	self.y = Players[0].y
	self.z = Players[0].z
	self.polygon = Players[0].polygon
	
	self.object = Items.new(self.x, self.y, self.z, self.polygon, "key")
	self.object:position(self.x, self.y, self.z, self.polygon)
	self.object._owner = key
	
	moveKey(self.id, Keys.player, Keys.level)
	
end

function giveKey(key)
	
	table.insert(Keys.player, key)
	
end

function moveKey(id, from, to)
	
	for k,v in ipairs(from) do
		
		if v.id == id then
			
			Players.print("Moving key " .. id .. ".")
			
			local key = table.remove(from, k)
			table.insert(to, key)
			break
			
		end
		
	end
	
end

function playerHasKey(id)

	local found = false

	for k,v in ipairs(Keys.player) do

		if v.id == id then
			
			found = true
			break
			
		end
		
	end
	
	return found
	
end


--Triggers.got_item()
function gotKeyItem()
	
	local checkKeyItems = function()
		
		for k,v in ipairs(Keys.level) do
			
			local key = v
			local found = false
			for i in Items() do
				if key.object == i then
					found = true
					break
				end
			end
		
			if not found then
				Players.print("Key Get")
				key:acquire()
			else
			end
		
		end
		
	end
	
	createTimer(1, false, checkKeyItems)
	
end