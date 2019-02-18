

-- Add item use, ItemClasses{}, initialization, itemtypes, etc.

Player.inventory = {}

Player.inventory.equip = { 
	["feet"] = nil,
	["legs"] = nil,
	["hands"] = { ["left"] = nil, ["right"] = nil },
	["body"] = { ["under"] = nil, ["over"] = nil },
	["back"] = nil,
	["face"] = nil,
	["head"] = nil
}

function Player.inventory:count(type)

	local n = 0

	for i = 1, # Player.inventory.list, 1 do
	
		local items = Player.inventory.list[i].contents
	
		for j = 1, # items, 1 do
			
			if items.name == type then
			
				n = n+1
				
			end
			
		end

	end
	
	return n

end

function Player.inventory:getTotalMass()

	local masses = 0

	for i = 1, # Player.inventory.list, 1 do
	
		local items = Player.inventory.list[i].contents
	
		for j = 1, # items, 1 do
			
			masses = masses + items[j]:getStoredMass()
			
		end
	
	end

	return masses

end

function Player.inventory:getTotalVolume()

	local volumes = 0

	for i = 1, # Player.inventory.list, 1 do
	
		local items = Player.inventory.list[i].contents
	
		for j = 1, # items, 1 do
			
			if not items[j].worn then
			
				volumes = volumes + items[j].volume
			
			end
			
		end
	
	end
	
	return volumes

end

function Player.inventory:updateInventoryString()

	local inventoryString = ""

	for i = 1, # Player.inventory.list, 1 do
		
		local item = Player.inventory.list[i]
	
		if ItemTypes[item.type]].class == "ammo" then
		
			inventoryString = inventoryString .. item.type .. ":" .. tostring(# item.contents)
	
		else
	
			inventoryString = inventoryString .. item.contents[1]:recursiveInventoryStrings()
		
		end
	
		inventoryString = inventoryString .. "\n"
	
	end
	
	Player.inventory.string = inventoryString
	
end



-- InventoryItem: Container for objectum in Player.inventory.list

InventoryItem = {}

function createInventoryItem(type)

	local inv = InventoryItem:new()
	inv.type = type
	inv.contents = {}
	
	inv.index = # Player.inventory.list + 1
	table.insert(Player.inventory.list, inv)

	return inv

end

function InventoryItem:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function InventoryItem:insert(item, check)

	if item.name ~= self.type then 
		
		return false 
	
	elseif Player.inventory:count(self.type) == ObjectumTypes[self.type].maxCount then
	
		Players.print("You can't carry any more " .. ObjectumTypes[self.type].plural .. ".")
		return false
	
	elseif Player.parameters.mass.current + item.mass > Player.parameters.mass.max then
	
		Players.print("It's too heavy to carry. Maybe if you drop something else?..")
		return false
		
	elseif Player.parameters.volume.current + item.volume > Player.parameters.volume.max then
	
		Players.print("It's too big to carry. Maybe if you drop something else?..")
		return false
		
	end
	
	if check then return true end

	local index = # self.contents + 1
	table.insert(self.contents, item)
	item.index = index
	item.parent = self

end

function InventoryItem:drop(item)

	local destination = createLevelItem(item.type, Player.me.x, Player.me.y, Player.me.z, Player.me.polygon, Player.me.facing)
	
	item:move(destination)
	
end

function InventoryItem:remove(item)

	local pop = table.remove(self.contents, item.index)

	if # self.contents <= 0 then
		table.remove(Player.inventory.list, self.index)
		self = nil
	end
	
	pop.index = nil
	pop.parent = nil
	pop.worn = nil
	return pop

end

function InventoryItem:equip(item)
	
	
	
end

function InventoryItem:unequip(item)


	
end

--LevelItem: Container for objectum in level, with corresponding scenery object

LevelItem = {}
LevelItem.all = {}

function createLevelItem(type, x, y, z, polygon, facing)

	local lItem = LevelItem:new()
	lItem.type = type
	lItem.contents = {}

	local object = ItemTypesM[type].object
	lItem.object = Scenery.new(x, y, z, polygon, object)
	lItem.object.facing = facing
	lItem.object._parent = lItem

	lItem.index = #LevelItem.all + 1
	table.insert(LevelItem.all, lItem)
	
	return lItem

end

function LevelItem:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function LevelItem:pickUp()

	local destination
	local item = self.contents[1]
	
	if ItemClasses[item.class].stacks then
		destination = Player.inventory:find(self.type)
	end
	
	if not destination then
		destination = createInventoryItem(self.type)
	end
	
	item:move(destination)
	
end

function LevelItem:insert(item, check)
	
	if check then return true end

	local index = # self.contents + 1
	table.insert(self.contents, item)
	item.index = index
	item.parent = self

end

function LevelItem:remove(item)

	local pop = table.remove(self.contents, item.index)

	if # self.contents <= 0 then
		self.object:delete()
		table.remove(LevelItem.all, self.index)
		self = nil
	end
	
	pop.index = nil
	pop.parent = nil
	return pop

end

function LevelItem:interaction()

	self:pickUp()
	
end


--Objectum: Core item object, held by InventoryItems and LevelItems

Objectum = {}
Objectum.all = {}

function createObjectum(type)

	local item = Objectum:new()
	
	item.name = type
	item.type = ItemTypesM[type]
	item.class = item.type.class
	item.effects = item.type.effects
	item.mass = item.type.mass
	item.maxMass = item.type.mass
	item.volume = item.type.volume
	item.accepts = item.type.accepts
	item.capacity = item.type.capacity
	item.worn = nil
	item.holding = 0
	item.object = item.type.object
	item.durability = 100
	
	item.contents = {}
	
	item.listing = # Objectum.all + 1
	table.insert = (Objectum.all, item)
	
	item.parent = nil
	
	return item
	
end

function Objectum:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Objectum:delete()

	if # self.contents > 0 then
		local killList = {}
		for i = 1, # self.contents, 1 do
			self.contents[i]:delete()
		end
	end

	if self.parent then
		self.parent:remove(self)
	end
	
	table.remove(Objectum.all, self.listing)
	
	self = nil
	
end

function Objectum:move(target)

	if target:insert(self, true) then
		self.parent:remove(self)
		target:insert(self, false)
		return true
	end
	
	return false
	
end

function Objectum:insert(item, check)
	
	local canFit = self:checkFit(item)
	
	if canFit == false then
		Players.print("You can't put the " .. item.type.singular .. " into the " .. self.type.singular .. ".")
		return false
	else
		if check then return true end
		local index = # self.contents + 1
		table.insert(self.contents, item)
		item.index = index
		item.parent = self
		self:updateHolding()
	end
	
end

function Objectum:remove(item)

	local pop = table.remove(self.contents, item.index)
	pop.index = nil
	pop.parent = nil
	return pop
	
	self:updateHolding()

end

-- Called before adding any item to an item's contents.
function Objectum:checkFit(candidate)

	local fits = false
	
	if self.accepts then
		if self.accepts == "all" then -- Bags and things do this.
			fits = true
		elseif # self.accepts > 1 then
			for i = 1, # self.accepts, 1 do
				if self.accepts[i] == candidate.name then
					fits = true
					break
				end
			end
		elseif self.accepts == candidate.name then
			fits = true
		end
		if self.class == "container" and candidate.class == "container" then -- Cannot place a bag in a bag, for uh, reasons.
			fits = false
		end
	else
		return false
	end

	if ItemClasses[self.class].holding == "volume" then
		if self.capacity - self.holding < candidate.volume then
			fits = false
		end
	else
		if self.holding == self.capacity then
			fits = false
		end
	end
	
	if self.type.CUC then -- Contents Unique Count items only hold one of each accepted type item.
		
		if self:isHoldingType(candidate.type) then
			fits = false
		end
		
	end
	
	return fits
	
end

-- Updates the item's current volume of contents for limit checks.
function Objectum:updateHolding()
	
	if ItemClasses[self.class].holding == "volume" then
		self.holding = 0
		for i = 1, # self.contents, 1 do
			self.holding = self.holding + self.contents[i].volume
		end
	else
		self.holding = # self.contents
	end
	
end

-- Recursive function. Returns the total mass of an item and all its contents.
function Objectum:getStoredMass()

	local massSum = self.mass

	if # self.contents > 0 then

		for i = 1, # self.contents, 1 do
		
			massSum = massSum + self.contents[i]:getStoredMass()
		
		end
		
	end
	
	return massSum
	
end

-- Returns boolean to determine whether a type of item is contained within this item.
-- Used for items like the taser, which should not have two batteries, or two dart packs, but a maximum of one each.
function Objectum:isHoldingType(type)

	local already = false

	if # self.contents > 0 then
	
		for i = 1, # self.contents, 1 do
		
			if self.contents[i].name == type then
				already = true
				break
			end
		
		end
		
	end
	
	return already
	
end

-- Returns a string with item names, details. 
-- Recursive down to last contained item. 
-- Used for displaying inventory listings in HUD.
function Objectum:recursiveInventoryStrings(l)

	l = l or 1

	local carryString = "self.name"

	if self.class == "magazine" or self.class == "container" or self.class == "rechargable" or self.class == "consumable" then

		carryString = carryString .. ":" self.holding .. "/" .. self.capacity .. ""

	end
	
	if # self.contents > 0 then
	
		for i = 1, l, 1 do
		
			carryString = carryString .. ";"
	
		end
	
		for i = 1, # self.contents, 1 do
	
			carryString = carryString .. self.contents[i]:recursiveInventoryStrings(l+1)
		
		end
	
	end

	return carryString
	
end

--[[
	
weapon
ammo
magazine
consumable
rechargeable
data
general
package
container
armor
	
]]

Objectum.classActions = {

	["weapon"] = {},
	["ammo"] = {},
	["magazine"] = {},
	["consumable"] = {},
	["rechargeable"] = {},
	["data"] = {},
	["general"] = {},
	["package"] = {},
	["container"] = {},
	["armor"] = {}

}

Objectum.effects = {}

Objectum.effects.targets = {

	["HP"] = { "HP", "target" },
	["Vit"] = { "Vit", "current" },
	["Sta"] = { "Sta", "current" },
	["Exh"] = { "Exh", "current" },
	["Tox"] = { "Tox", "target" }

}