-- Rooms.lua

Rooms = {}

function initRooms()

	local RoomSeeds = getAnnotations("Room", nil)
	
	for i = 1, # RoomSeeds, 1 do
	
		local note = filterCSVLine(RoomSeeds[i].text)
		createRoom(RoomSeeds[i].polygon, note[2])
		
	end

end

RoomList = {}

function createRoom(seedPolygon, id)

	local room = Rooms:new()
	
	room.id = id
	
	room.polygons = {}

	polyScan(seedPolygon, room.polygons)
	
	table.insert(RoomList, room)

end

function polygonHasDoor(polygon)

	if polygon._doorSet then
		return true
	else
		return false
	end
	
end

function polygonHasWindow(polygon)
	
	local window = false
	
	for s in polygon:sides() do
	
		if not s.transparent.empty then
			window = true
			break
		end
		
	end
	
	return window
	
end

function polygonInList(polygon, list)
	
	local inList = false
	
	for k, v in ipairs(list) do
		
		if v == polygon then
			inList = true
			break
		end
		
	end
	
	return inList
	
end

function polyScan(polygon, list)
	
	if not polygonInList(polygon, list) then
		table.insert(list, polygon)
	end
	
	if polygonHasWindow(polygon) then
		return
	end
	
	if polygonHasDoor(polygon) then
		return
	end
	
	if polygon.type == "platform" or polygon.type == "superglue" then
		return
	end
	
	for p in polygon:adjacent_polygons() do
		if not polygonInList(p, list) then
			polyScan(p, list)
		end
	end
	
end

function getPlayerRoom()

	local room = "none"

	for i = 1, # RoomList, 1 do
	
		if RoomList[i]:hasPolygon(Player.me.polygon) then
			room = RoomList[i].id
			break
		end
		
	end

	return room
	
end

function Rooms:hasPolygon(polygon)

	local hasPolygon = false

	for i = 1, # self.polygons, 1 do
	
		if self.polygons[i] == polygon then
			hasPolygon = true
			break
		end
		
	end
	
	return hasPolygon
	
end

function Rooms:new()

	o = {}
    setmetatable(o, self)
    self.__index = self
	return o

end

