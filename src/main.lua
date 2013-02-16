--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require('debug')
-- require("game.gamestate")
require('game/physics')
require('game/boy')

PLAYER_W = 10
PLAYER_H = 10

p = nil

objects = {}

PHY_METER_RATIO = 64
GRAVITY = 9.81

function initPhysics(  )
	world = love.physics.newWorld(0, GRAVITY*PHY_METER_RATIO, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	love.physics.setMeter(PHY_METER_RATIO) --the height of a meter our worlds will be 64px
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function love.load()
	initPhysics()
	p = Boy:new()
	
	--let's create the ground
	objects.ground = {}
	local shape1W = 1500
	local shape1H = 50
	
	local shape2H = 50
	local shape2W = 10000
	
	-- 
	
	local shape1X = 0
	local shape1Y = 600
	
	local shape2X = 400
	local shape2Y = 300

	objects.ground.body = love.physics.newBody(world, shape1X+shape1W/2, shape1Y-shape1H/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.ground.shape = love.physics.newRectangleShape(shape1W, shape1H) --make a rectangle with a width of 650 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
	objects.ground.fixture:setUserData("GROUND")
 

	-- objects.ground.body2 = love.physics.newBody(world, shape2X+shape2W/2, shape2Y-shape2H/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	-- objects.ground.shape2 = love.physics.newRectangleShape(shape2W, shape2H) --make a rectangle with a width of 650 and a height of 50
	-- objects.ground.fixture2 = love.physics.newFixture(objects.ground.body2, objects.ground.shape2); --attach shape to body
	
	--let's create a couple blocks to play around with
	-- objects.block1 = {}
	-- objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
	-- objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	-- objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	-- objects.block2 = {}
	-- objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
	-- objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	-- objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
	love.graphics.setMode(650, 650, false, true, 0) --set the window dimensions to 650 by 650

end

function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    print ("p=", tostring(p))
    p:collideWith(b:getUserData(), coll)
    print ("\n"..tostring(a:getUserData()).." colliding with "..tostring(b:getUserData()).." with a vector normal of: "..x..", "..y)
    a:getUserData():collideWith(b:getUserData(), coll)

end

persisting = 0

function endContact(a, b, coll)
    persisting = 0    -- reset since they're no longer touching
    print ("\n"..tostring(a:getUserData()).." uncolliding with "..tostring(b:getUserData()))
end

function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        print ("\n"..tostring(a:getUserData()).." touching "..tostring(b:getUserData()))
    elseif persisting < 20 then    -- then just start counting
        print (" "..persisting)
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll)
-- we won't do anything with this function
end

function love.update(dt)
  p:update(dt)
  world:update(dt) --this puts the world into motion

  --here we are going to create some keyboard events
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
  	p:right()
  end
  if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
  	p:left()
  end
  if love.keyboard.isDown(" ") then --press the left arrow key to push the ball to the left
  	p:jump()
  end
end

function love.draw()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	-- print (tostring(objects.ground.body:getPosition().getX()))
	-- love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
	-- love.graphics.rectangle("fill", a, b, )
	p:draw()

	-- love.graphics.setColor(255, 0, 0) -- set the drawing color to green for the ground
	-- love.graphics.polygon("fill", objects.ground.body2:getWorldPoints(objects.ground.shape2:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	-- love.graphics.circle("fill", p.body:getX(), p.body:getY(), p.shape:getRadius())

	-- love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	-- love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	-- love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
end
