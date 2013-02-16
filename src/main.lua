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

PHY_METER_RATIO = 64
GRAVITY = 9.81

function initPhysics(  )
	world = love.physics.newWorld(0, GRAVITY*PHY_METER_RATIO, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	love.physics.setMeter(PHY_METER_RATIO) --the height of a meter our worlds will be 64px
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
	local shape1W = 1500
	local shape1H = 50
	local shape1X = 0
	local shape1Y = 550
	
	objects.ground.body = love.physics.newBody(world, shape1X+shape1W/2, shape1Y-shape1H/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.ground.shape = love.physics.newRectangleShape(shape1W, shape1H) --make a rectangle with a width of 650 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
	objects.ground.fixture:setUserData("GROUND")
 
	gameState = GameState:new()
end

function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    -- print ("p=", tostring(p))
    -- p:collideWith(b:getUserData(), coll)
    -- print ("\n"..tostring(a:getUserData()).." colliding with "..tostring(b:getUserData()).." with a vector normal of: "..x..", "..y)
    -- print (a, b)
    -- a:getUserData():collideWith(b:getUserData(), coll)
end

persisting = 0

function endContact(a, b, coll)
    persisting = 0    -- reset since they're no longer touching
    -- print ("\n"..tostring(a:getUserData()).." uncolliding with "..tostring(b:getUserData()))
end

function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        -- print ("\n"..tostring(a:getUserData()).." touching "..tostring(b:getUserData()))
    elseif persisting < 20 then    -- then just start counting
        -- print (" "..persisting)
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
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
    else
		gameState:keyPressed(key, unicode)
	end
end

function love.keyreleased(key, unicode)
end

function love.update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
	gameState:update(dt)
end	

function love.draw()
	gameState:draw()
end