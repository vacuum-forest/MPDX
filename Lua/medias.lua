-- Medias.lua

Medias = {}

function initMedias()

	Medias.water = {}
	Medias.water.viscosity = 1
	Medias.water.damage = nil
	Medias.water.swimmable = true
	Medias.water.haze = {["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5, ["d"] = {["min"] = 4, ["max"] = 20}} 

	Medias.lava = {}
	Medias.lava.viscosity = 10
	Medias.lava.swimmable = false
	Medias.lava.haze = {["r"] = 1, ["g"] = 1, ["b"] = 0, ["d"] = {["min"] = 4, ["max"] = 20}} 

	Medias.goo = {}
	Medias.goo.viscosity = 0.5
	Medias.goo.swimmable = true
	Medias.goo.haze = {["r"] = 0, ["g"] = 0.5, ["b"] = 0.5, ["d"] = {["min"] = 4, ["max"] = 20}} 

	Medias.sewage = {}
	Medias.sewage.viscosity = 2.5
	Medias.sewage.swimmable = true
	Medias.sewage.haze = {["r"] = 0.39453125, ["g"] = 0.32421875, ["b"] = 0.09765625, ["d"] = {["min"] = 0.5, ["max"] = 2}} 

	Medias.jjaro = {}
	Medias.jjaro.viscosity = 1
	Medias.jjaro.swimmable = true
	Medias.jjaro.haze = {["r"] = 0, ["g"] = 0.5, ["b"] = 0.5, ["d"] = {["min"] = 4, ["max"] = 20}}

	MediaTypes["water"].mnemonic = "water"
	MediaTypes["water"]._details = Medias.water

	MediaTypes["lava"].mnemonic = "lava"
	MediaTypes["lava"]._details = Medias.lava

	MediaTypes["goo"].mnemonic = "goo"
	MediaTypes["goo"]._details = Medias.goo

	MediaTypes["sewage"].mnemonic = "sewage"
	MediaTypes["sewage"]._details = Medias.sewage

	MediaTypes["jjaro"].mnemonic = "jjaro"
	MediaTypes["jjaro"]._details = Medias.jjaro 

	Level.underwater_fog.active = true

end

function mediasIdleUpkeep()

	if Player.me.feet_below_media or Player.me.head_below_media then
	
		Medias.updateFog()
	
	end
	
end

function heightToSurface()

	return Player.me.polygon.media.height - Player.me.z
	
end

function Medias.updateFog()
	
	if Player.me.polygon.media then
	
		local media = Player.me.polygon.media.type._details
		local floorLight = Player.me.polygon.floor.light.intensity
		local depthMod = 1.5 / math.max(1.5, heightToSurface())
	
		Level.underwater_fog.color.r = media.haze.r * floorLight * depthMod
		Level.underwater_fog.color.g = media.haze.g * floorLight * depthMod
		Level.underwater_fog.color.b = media.haze.b * floorLight * depthMod
		Level.underwater_fog.depth = math.max(media.haze.d.max * (1 - floorLight) * depthMod, media.haze.d.min)

	end

end