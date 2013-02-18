--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]


Storyline = {}
Storyline.__index = Storyline

function Storyline:new()
    local self = {}
    setmetatable(self, Storyline)
    self.timerLenght =28.5
    self.timer = 0
    self.img = love.graphics.newImage(ImgDirectory.."origin.jpg")

    return self
end


function Storyline:mousePressed(x, y, button)
end

function Storyline:mouseReleased(x, y, button)
end

function Storyline:keyPressed(key, unicode)
	if key == "return" then
		gameState:changeState('Menu')
	end
end
function Storyline:keyReleased(key, unicode)
end



function Storyline:update(dt)
	self.timer = self.timer+dt
	if self.timer >=self.timerLenght then
		self.img=nil
		gameState:changeState('Menu')
	end
end

function Storyline:draw()
		love.graphics.draw(self.img,250,-self.timer*400)
end