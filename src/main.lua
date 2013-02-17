--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require('debug')
require("game/gamestate")
require('game/physics')
require('game/boy')

p = nil

objects = {}

ShowHitBoxes = false
StopScroll = false

PHY_METER_RATIO = 64
GRAVITY = 20.92 -- 9.81

function initPhysics(  )
	love.physics.setMeter(PHY_METER_RATIO) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, GRAVITY*PHY_METER_RATIO, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end
SourceDirectory="./"
ImgDirectory="img/"
PlatformDirectory="platforms/"
gameState = nil

function love.load()
	initPhysics()
	
	--let's create the ground
	objects.ground = {}
	local shape1W = 1000500
	local shape1H = 50
	local shape1X = 0
	local shape1Y = 550
	
	-- objects.ground.body = love.physics.newBody(world, shape1X+shape1W/2, shape1Y-shape1H/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	-- objects.ground.shape = love.physics.newRectangleShape(shape1W, shape1H) --make a rectangle with a width of 650 and a height of 50
	-- objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
	-- objects.ground.fixture:setUserData("GROUND")
 
	gameState = GameState:new()
end

function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    -- print ("p=", tostring(p))
    -- p:collideWith(b:getUserData(), coll)
    -- print ("\n"..tostring(a:getUserData()).." colliding with "..tostring(b:getUserData()).." with a vector normal of: "..x..", "..y)
    
    -- print (a, b)
    -- print (a:getUserData())
    a:getUserData():collideWith(b:getUserData(), coll)
    b:getUserData():collideWith(a:getUserData(), coll)
end

persisting = 0

function endContact(a, b, coll)
    persisting = 0    -- reset since they're no longer touching
    -- print ("\n"..tostring(a:getUserData()).." uncolliding with "..tostring(b:getUserData()))
end

function preSolve(a, b, coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()

    if o1.preSolve then
    	o1:preSolve(o2, coll)
    end

    if o2.preSolve then
    	o2:preSolve(o1, coll)
    end
end

function postSolve(a, b, coll)
-- we won't do anything with this function
end

function love.update(dt)
	gameState:update(dt)
end	

function love.mousepressed(x, y, button)
	gameState:mousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	gameState:mouseReleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
	gameState:keyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
end

function love.update(dt)
	gameState:update(dt)
end	

function love.draw()
	gameState:draw()
end