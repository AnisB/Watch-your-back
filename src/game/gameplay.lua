--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.environment")
require("game.background")
require("game.proxbackground")
require("game.hud")
require("game.pedobear")
require("game.sound")
require("game.backgroundinter1")
require("game.backgroundinter2")

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)
	p = Boy.new(self)

	--the background for our scene
	self.scene = love.graphics.newImage("bg.png")
	-- the character we will be moving around
	self.person = love.graphics.newImage("dude.jpg")
	-- an object to move around
	self.object = love.graphics.newImage("ball.jpg")


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
	
	
	-- HUD --
	self.hud = Hud:new(self)

	-- PEDO
	self.pedobear = Pedobear:new()

	self.firstRun=true
	
	-- counter teleport --
	self.timerT = 0
	self.teleportActive=false
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
	end
end

function Gameplay:keyReleased(key, unicode)

end


function Gameplay:enableTeleport()
	print("Enable")
	self.teleportActive=true
	self.timerT=10
	p:enableTeleport(true)
end
function Gameplay:update(dt)
	if self.teleportActive then
		print("active")
		self.timerT = self.timerT-dt
		if  self.timerT<=0 then
			p:enableTeleport(false)
			self.teleportActive=false
		end
	end 
	if self.firstRun then
	Sound.playMusic("themeprincipal")
	self.firstRun =false
	end
	
	p:update(dt)
	world:update(dt) --this puts the world into motion

	--here we are going to create some keyboard events
	if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
		p:right()
	elseif love.keyboard.isDown("q") or  love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
		p:left()
	else 
		p:still()
	end
	if love.keyboard.isDown("z") or love.keyboard.isDown("w") or love.keyboard.isDown(" ") then --press the left arrow key to push the ball to the left
		p:jump()
	end
	self.timeelapsed=self.timeelapsed +dt
	self.environment:update(dt)
	self.scrolledDistance=math.floor(self.scrolledDistance+dt*200+self.timeelapsed/100)
	self.background:update(dt)
	self.backgroundinter1:update(dt)
	self.backgroundinter2:update(dt)
	self.proxbackground:update(dt)

end

function Gameplay:draw()
	self.background:draw()
	self.proxbackground:draw()
	self.environment:draw()
	self.backgroundinter1:draw()
	self.backgroundinter2:draw()
	-- Draw the HUD (obviously at the end)
	self.hud:draw()
	p:draw()
	self.pedobear:draw()
end
