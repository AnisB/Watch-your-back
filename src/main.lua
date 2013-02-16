--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
-- require("game.gamestate")
Player = {}

world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
love.physics.setMeter(64) --the height of a meter our worlds will be 64px

Player = {}
Player.__index = Player

function Player.create(x, y)
	local p = {}						 -- our new object
	setmetatable(p, Player)	-- make Player handle lookup
	p.body = love.love.physics.newBody(world, x, y)
	p.shape = love.physics.newRectangleShape(PLAYER_W, PLAYER_H)
	p.fixture = love.physics.newFixture(p.body, p.shape, 1) -- Attach fixture to body and give it a density of 1 (rigid body)
	p.fixture:setRestitution(0.8) --let the player bounce
	return p
end

function Player:withdraw(amount)
	self.balance = self.balance - amount
end

-- create and use an Player


function love.load()

	objects = {} -- table to hold all our physical objects
	p = Player.create(3, 3)
	
	--let's create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
	
	--let's create a player
	

	--let's create a couple blocks to play around with
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
	love.graphics.setMode(650, 650, false, true, 0) --set the window dimensions to 650 by 650
end

function love.draw()
	world:update(dt) --this puts the world into motion
	
	--here we are going to create some keyboard events
	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		objects.ball.body:applyForce(400, 0)
	elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		objects.ball.body:applyForce(-400, 0)
	elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
		objects.ball.body:setPosition(650/2, 650/2)
	end

	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

	love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
end
