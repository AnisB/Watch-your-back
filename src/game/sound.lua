Sound = {}
Sound.__index = Sound

Sound.SOUND_ROOT = "sound/"
Sound.sources = {}
Sound.currentMusic = nil

--[[--
UTILISATION :

	Les trois contrôles standard :
		Sound.play() : play
		Sound.pause() : pause
		Sound.stop() : stop

	Jouer une musique (longue durée) :
		Sound.playMusic("nom")

	Jouer un son (durée très courte) :
		Sound.playSound("nom")

--]]--

Sound.play = function ()
	if Sound.currentMusic then Sound.currentMusic:play() end
end

Sound.pause = function ()
	if Sound.currentMusic then Sound.currentMusic:pause() end
end

Sound.stop = function ()
	if Sound.currentMusic then Sound.currentMusic:stop() end
end

Sound.playMusic = function (name,isLoop)
	if Sound.sources[name] == nil then
		Sound.preload(name,isLoop)
	end
	local src = Sound.sources[name]
	if src == Sound.currentMusic then
		return
	else
		if Sound.currentMusic then
			Sound.currentMusic:stop()
		end
		Sound.currentMusic = src
		Sound.currentMusic:play()
	end
end

Sound.playSound = function (name)
	local path = Sound.SOUND_ROOT..name..'.ogg'
	local src = love.audio.newSource(path, "static")
	src:play()
end

-- PRIVATE
Sound.preload = function (name,isLoop)
	if Sound.sources[name] ~= nil then
		return
	end
	local path = Sound.SOUND_ROOT..name..'.ogg'
	local src = love.audio.newSource(path)
	src:setLooping(isLoop)
	Sound.sources[name] = src
end