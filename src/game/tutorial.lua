--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require("game.button")
Tutorial = {}
Tutorial.__index = Tutorial

function Tutorial:new()
    local self = {}
    setmetatable(self,Tutorial)
    self.font = love.graphics.newImage(ImgDirectory.."tutobackground.jpg")
    local options = {x =200,y = 200,sizex=100,sizey=100}
    self.buttonTut = Button:new(options)
    local options = {x =200,y = 200,sizex=100,sizey=100}
    return self
end

function Tutorial:mousePressed(x, y, button)
	print(x,y)
	self.buttonTut:mousePressed(x, y)
end

function Tutorial:mouseReleased(x, y, button)
	if self.buttonTut:askReleased(x, y) then
		gameState:changeState('Menu')
	end
end

function Tutorial:keyPressed(key, unicode)
end

function Tutorial:keyReleased(key, unicode)
end

function Tutorial:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function Tutorial:draw()
	love.graphics.draw(self.font,0,0)
	self.buttonTut:draw()
end
