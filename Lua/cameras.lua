function initCameras()

	CameraTypes = {}

	CameraTypes[0] = {}
	CameraTypes[0].mnemonic = "Plain"
	CameraTypes[0].fisheye = false
	CameraTypes[0].predator = false

	CameraTypes[1] = {}
	CameraTypes[1].mnemonic = "Plain Wide"
	CameraTypes[1].fisheye = true
	CameraTypes[1].predator = false
	
	CameraTypes[2] = {}
	CameraTypes[2].mnemonic = "Nightvision"
	CameraTypes[2].fisheye = false
	CameraTypes[2].predator = true
	
	CameraTypes[3] = {}
	CameraTypes[3].mnemonic = "Nightvision Wide"
	CameraTypes[3].fisheye = true
	CameraTypes[3].predator = true
	
	FadeTypes["dodge yellow"].mnemonic = "camera normal"
	FadeTypes["burn green"].mnemonic = "camera nightvision"

	setUpCameras()

end


Cams = {}

Cams.maxViewTime = 18000 -- Roughly like 10 minutes, maybe?

function installCamera(name, type, x, y, z, polygon, yaw, pitch)

	local cam = Cams:new()
	
	cam.type = CameraTypes[type]
	cam.x = x
	cam.y = y
	cam.z = z
	cam.polygon = polygon
	cam.yaw = yaw
	cam.pitch = pitch
	
	local camera = Cameras.new()
	
	cam.camera = camera
	
	Cams[name] = cam
	
end

function Cams:new()
	
	o = {}
    setmetatable(o, self)
    self.__index = self
	return o
	
end

function Cams:start()
	
	Player.freeze()
	
	Player.camera.timer = Cams.maxViewTime -- Like 10 minutes in engine ticks, ~ish...
	self.camera.path_angles:new(self.yaw, self.pitch, Cams.maxViewTime)
	self.camera.path_points:new(self.x, self.y, self.z, self.polygon, Cams.maxViewTime)
	self.camera:activate(Player.me)
	Player.camera.current = self
	
	for k, v in pairs(Cams) do
		if v == self then Player.submode = k break end
	end

	Player.mode = "camera"
	
end

function Cams:stop()
	
	Player.me:fade_screen("cinematic fade in")
	
	self.camera:deactivate(Player.me)
	
	Player.camera.current = nil
	Player.me.extravision_duration = 0
	Player.me.infravision_duration = 0
	
	Player.defrost()
	
	Player.mode = "default"
	
end

function Cams:interaction(remote)
	
	if remote then
		if Player.camera.current == self then
			self:stop()
		else
			self:start()
		end
	else
		-- Do something to a camera object, like hack it physically? Dunno. Move it around?
	end
	
end


function setUpCameras()

	local note = {}

	for a in Annotations() do
	
		note = filterCSVLine(a.text)
		
		if note[1] == "Camera" then
			
			local c = {}
			c.name = note[2]
			c.type = tonumber(note[3])
			c.height = tonumber(note[4])
			c.yaw = tonumber(note[5])
			c.pitch = tonumber(note[6])
			
			installCamera(c.name, c.type, a.x, a.y, c.height, a.polygon, c.yaw, c.pitch)
			
		end
		
	end

end


function camsIdleUpkeep()

if Player.camera.current then	

	local cam = Player.camera.current
	
	Player.camera.timer = Player.camera.timer - 1
	
	if Player.camera.timer > 0 then

		if cam.type.fisheye then
			Player.me.extravision_duration = 7
		end
	
		if cam.type.predator then
			
			Player.me.infravision_duration = 7
			
			if Player.camera.timer % 2 == 1 then
				--Player.me:fade_screen("camera nightvision b")
			else
				Player.me:fade_screen("camera nightvision")
			end
			
		else
		
			Player.me:fade_screen("camera normal")
			
		end
		
	else
		
		cam:stop()
		Player.me:print("Your eyes got tired of watching the feed.")
	
	end
	
end
	
end