--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict')
require('game.hud')


GameOver = {}
GameOver.__index = GameOver
function GameOver:new(gameplay)
    local self = {}
    setmetatable(self, GameOver)
    self.gp = gameplay
    self.background = love.graphics.newImage(ImgDirectory.."gameover.png")
	self.timer = 5
    return self
end


function GameOver:mousePressed(x, y, button)
	-- love.event.push("quit")
end

function GameOver:mouseReleased(x, y, button)
end


function GameOver:keyPressed(key, unicode)
end

function GameOver:keyReleased(key, unicode)
end


function GameOver:update(dt)
	self.timer= self.timer-dt
	if self.timer<=0 then
		self.gp:reset()
		self.timer = 5
		gameState:changeState('Menu')
	end
	
end

function GameOver:draw()
	love.graphics.draw(self.background, 0, 0)
	Hud.drawScore(self.gp.playerState:getScore(), 575, 510)
end
