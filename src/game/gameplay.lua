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
require("game.bonus")
Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)


	-- Background --
	self.scrolledDistance=0
	self.speed=100
	self.ceil = 0
	self.timeelapsed=0
	self.background = Background:new(self)
	self.cron = require('game.cron')
	self.proxbackground = ProxBackground:new(self)
	self.backgroundinter1 = BackgroundInter1:new(self)
	self.backgroundinter2 = BackgroundInter2:new(self)
	self.environment = Environment:new(self)

	-- Character -- 
	p = Boy.new(self)
	
	-- Player state --
	self.playerState = PlayerState:new(self)
	
	-- HUD --
	self.hud = Hud:new(self)

	-- PEDO
	self.pedobear = Pedobear:new()

	-- Foreground (red filter)
	self.foreground = Foreground:new(255, 0, 0)

	-- Bonuses
	self.bonuses = {}
	local function popBonus()
		local choice = math.random(1, #Bonus.NUMANIMS)
		choice = Bonus.NUMANIMS[choice]
		Bonus.new(self, self.bonuses, choice.name)
		self.cron.after(math.random(12, 15), popBonus)
	end
	self.cron.after(math.random(12, 15), popBonus)

	self.firstRun=true
	self.coeff_value = 1
	self.cron.every(0.6, function() 
		self.coeff_value = self.coeff_value * 0.96
		if self.coeff_value < 0.1 then
			self.coeff_value = 0.1
		end
	end)

	return self
end

function Gameplay:reset()
	world:setCallbacks(nil, function() collectgarbage() end)
	world:destroy()
	love.physics.setMeter(PHY_METER_RATIO) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, GRAVITY*PHY_METER_RATIO, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	PhysicsComponent.reset()
	self.scrolledDistance=0
	self.speed=100
	self.ceil = 0
	self.timeelapsed=0
	p:reset()
	self.pedobear:reset()
	self.background:reset()
	self.proxbackground:reset()
	self.backgroundinter1:reset()
	self.backgroundinter2:reset()
	self.environment:reset()
	self.playerState:reset()
	self.firstRun=true
	self.coeff_value = 1
	self.bonuses = {}
	local function popBonus()
		local choice = math.random(1, #Bonus.NUMANIMS)
		choice = Bonus.NUMANIMS[choice]
		Bonus.new(self, self.bonuses, choice.name)
		self.cron.after(math.random(12, 15), popBonus)
	end
	self.cron.after(math.random(12, 15), popBonus)
	
end

function Gameplay:mousePressed(x, y, button)
	if self.playerState.currentPowerUp == 'teleport' then
		p:teleport(x+self.scrolledDistance, y)
	end	
end

function Gameplay:mouseReleased(x, y, button)

end

function Gameplay:keyPressed(key, unicode)
	-- print("hi")
	if key == "t" then
		self.playerState:enableTeleport()
	elseif key == "i" then
		self.playerState:enableInvincible()
	elseif key == "f" then
		self.playerState:enableFlying()
	elseif key == "b" then
		self.playerState:enableBomb()
	end
end

function Gameplay:keyReleased(key, unicode)
end

function Gameplay:disableGravity(  )
	world:setGravity(0.0, 0.0)
	p:disableUpPulse()
end

function Gameplay:enableGravity(  )
	world:setGravity(0.0, GRAVITY*PHY_METER_RATIO)
	p:enableUpPulse()
end

function Gameplay:update(dt)
	if self.playerState.currentPowerUp ~= nil then
		self.playerState.powerUpRemTime = self.playerState.powerUpRemTime-dt
		if  self.playerState.powerUpRemTime <= 0 then
			self.playerState:disablePowerUp()
		end
	end

	if self.firstRun then
		Sound.playMusic("themeprincipal")
		self.firstRun = false
	end

	--here we are going to create some keyboard events
	if self.playerState.currentPowerUp ~= 'bombe' and (love.keyboard.isDown("z") or love.keyboard.isDown("w") or love.keyboard.isDown(" ")) then --press the left arrow key to push the ball to the left
		p:jump()
	end
	if self.playerState.currentPowerUp == 'bombe' then
		p:still()
	elseif love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
		p:right()
	elseif love.keyboard.isDown("q") or love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
		p:left()
	elseif love.keyboard.isDown("s") then
		p:down()
	else 
		p:still()
	end

	if love.keyboard.isDown("m") then
		if Sound.isPaused then
			Sound.play()
		else
			Sound.pause()
		end
	end

	p:update(dt)
	world:update(dt) --this puts the world into motion
	
	self.timeelapsed=self.timeelapsed+dt
	self.environment:update(dt)
	if StopScroll then 
		self.scrolledDistance = 0
	else
		self.scrolledDistance = self.scrolledDistance + dt*100 + self.timeelapsed*self.coeff_value
	end

	self.background:update(dt)
	self.cron.update(dt)
	self.backgroundinter1:update(dt)
	self.backgroundinter2:update(dt)
	self.proxbackground:update(dt)
	self.playerState:update()
	self.foreground:setAlphaFromDangerLevel(self.playerState.dangerLevel)
	
	local x,y = p:getPos()
	if (x- self.scrolledDistance)> 1024 then
		x=	1023 + self.scrolledDistance
		p.pc.body:setPosition(x,y)
	end
	if (x - self.scrolledDistance)< 0 or y > love.graphics:getHeight()+20 then
		gameState:changeState('GameOver')
		Sound.playMusic("berceuse")
	end

	if y < self.ceil then
		y = self.ceil+1
		p.pc.body:setPosition(x, y)
	end

	self.pedobear:update(dt)
end

function Gameplay:draw()
	self.background:draw()
	self.backgroundinter1:draw()
	self.backgroundinter2:draw()
	self.proxbackground:draw()
	self.environment:draw()
	p:draw()
	for i=1, #self.bonuses do
		self.bonuses[i]:draw()
	end
	self.pedobear:draw()
	self.foreground:draw()
	-- Draw the HUD (obviously at the end)
	self.hud:draw()
	-- Are you trying to write something after this line? Did you read the previous comment? Hmm.
end
