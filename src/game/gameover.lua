--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

GameOver = {}
GameOver.__index = GameOver
function GameOver:new()
    local self = {}
    setmetatable(self, GameOver)
    self.background = love.graphics.newImage(ImgDirectory.."gameover.png")
    return self
end

function GameOver:mousePressed(x, y, button)
	gameState:changeState('Menu')
	Sound.playMusic("berceuse")
end

function GameOver:mouseReleased(x, y, button)

end

function GameOver:keyPressed(key, unicode)
	
end

function GameOver:keyReleased(key, unicode)

end

function GameOver:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
end

function GameOver:draw()
	love.graphics.draw(self.background, 0, 0)
end
