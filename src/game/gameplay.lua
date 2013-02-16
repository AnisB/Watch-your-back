--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.environment")
require("game.background")

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)

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
	self.background = Background:new()
	self.environment = Environment:new()

	return self
end

function Gameplay:mousePressed(x, y, button)

end

function Gameplay:mouseReleased(x, y, button)

end

function Gameplay:keyPressed(key, unicode)
	
end

function Gameplay:keyReleased(key, unicode)

end

function Gameplay:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
	self.environment:update(dt)
end

function Gameplay:draw()

	self.environment:draw()
end

function Gameplay.test()
end