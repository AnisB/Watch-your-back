--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.environment")
require("game.background")
require("game.foreground")
require("game.proxbackground")
require("game.hud")
require("game.pedobear")
require("game.sound")
require("game.backgroundinter1")
require("game.backgroundinter2")
require("game.playerstate")
Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)
	p = Boy.new(self)


	-- the character position
	self.character = {400,400} -- x,y

	-- a bunch of objects, each with a position
	self.objects = {}
	self.objects[1] = {550,370}
	self.objects[2] = {220,390}
	self.objects[3] = {600,410}
	self.objects[4] = {300,450}
	self.objects[5] = {400,530}

	-- Background --
	self.scrolledDistance=0
	self.speed=100
	self.timeelapsed=0
	self.background = Background:new(self)
	self.proxbackground = ProxBackground:new(self)
	self.backgroundinter1 = BackgroundInter1:new(self)
	self.backgroundinter2 = BackgroundInter2:new(self)
	self.environment = Environment:new(self)

	-- Character -- 
	-- self.boy = Boy
	
	-- Player state --
	self.playerState = PlayerState:new(self)
	
	-- HUD --
	self.hud = Hud:new(self)

	-- PEDO
	self.pedobear = Pedobear:new()

	-- Foreground (red filter)
	self.foreground = Foreground:new(255, 0, 0)

	self.firstRun=true
	
	-- counter teleport --
	self.timerT = 0
	self.timerI = 0
	self.teleportActive=false
	
	-- counter flying --
	self.timerFlying = 0
	self.flyingActive=false
	
	self.invincibleActive=false
	return self
end

function Gameplay:mousePressed(x, y, button)
	if self.teleportActive then
		p:teleport(x+self.scrolledDistance,y)
	end	
end

function Gameplay:mouseReleased(x, y, button)

end

function Gameplay:keyPressed(key, unicode)
	print("hi")
	if key == "t" then
		self:enableTeleport()
	elseif key == "i" then
		self:enableInvincible()
	end
	if key == "f" then
		self:enableFlying()
	end
	
end

function Gameplay:keyReleased(key, unicode)

end


function Gameplay:enableTeleport()
	self.teleportActive=true
	self.timerT=10
	p:enableTeleport(true)
end

function Gameplay:enableFlying()
	self.flyingActive=true
	self.timerFlying=10
	p:enableFlying(true)
	
	end
function Gameplay:enableInvincible()
	print("Enable Invincible")
	self.invincibleActive=true
	self.timerI=10
	p:enableInvincible(true)
end


function Gameplay:update(dt)
	if self.teleportActive then
		self.timerT = self.timerT-dt
		if  self.timerT<=0 then
			p:enableTeleport(false)
			self.teleportActive=false
		end
	end
	if self.invincibleActive then
		print("invincible active")
		self.timerI = self.timerI-dt
		if  self.timerI<=0 then
			p:enableInvincible(false)
			self.invincibleActive=false
		end
	end 
	
	if self.flyingActive then
		self.timerFlying = self.timerFlying-dt
		if  self.timerFlying<=0 then
			p:enableFlying(false)
			self.flyingActive=false
		end
	end 
	
	
	if self.firstRun then
	Sound.playMusic("themeprincipal")
	self.firstRun =false
	end

	--here we are going to create some keyboard events
	if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
		p:right()
	elseif love.keyboard.isDown("q") or love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
		p:left()
	else 
		p:still()
	end
	if love.keyboard.isDown("z") or love.keyboard.isDown("w") or love.keyboard.isDown(" ") then --press the left arrow key to push the ball to the left
		p:jump()
	end

	p:update(dt)
	world:update(dt) --this puts the world into motion
	
	self.timeelapsed=self.timeelapsed+dt
	self.environment:update(dt)
	if StopScroll then 
		self.scrolledDistance = 0
	else
		self.scrolledDistance = self.scrolledDistance+dt*200+self.timeelapsed/100
	end

	self.background:update(dt)
	self.backgroundinter1:update(dt)
	self.backgroundinter2:update(dt)
	self.proxbackground:update(dt)
	self.playerState:update()
	self.foreground:setAlphaFromDangerLevel(self.playerState.dangerLevel)
end

function Gameplay:draw()
	self.background:draw()
	self.proxbackground:draw()
	self.environment:draw()
	self.backgroundinter1:draw()
	self.backgroundinter2:draw()
	p:draw()
	self.pedobear:draw()
	self.foreground:draw()
	-- Draw the HUD (obviously at the end)
	self.hud:draw()
	-- Are you trying to write something after this line? Did you read the previous comment? Hmm.
end
