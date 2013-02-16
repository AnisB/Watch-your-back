--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require("game.gamestate")

SourceDirectory="./"
ImgDirectory="img/"


function love.load()
	gameState = GameState.new()
end

function love.mousepressed(x, y, button)
	GameState:mousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	GameState:mouseReleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
    else
		GameState:keyPressed(key, unicode)
	end
end

function love.keyreleased(key, unicode)
end

function love.update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
end	

function love.draw()
	gameState:draw()
end
