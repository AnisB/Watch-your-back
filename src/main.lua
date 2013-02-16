--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.gamestate")

SourceDirectory="./"
ImgDirectory="img/"
PlatformDirectory="platforms/"
gameState = nil


function love.load()
	gameState = GameState.new()
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
