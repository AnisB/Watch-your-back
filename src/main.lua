--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.gamestate")

function love.load()
	gameS = GameState.new{}
end

function love.mousepressed(x, y, button)
	gameS:mousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	gameS:mouseReleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
    else then
	
	end
end

function love.keyreleased(key, unicode)
end

function love.update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
	
	gameS:update(dt)
end

function love.draw()
	gameS:draw()
end
