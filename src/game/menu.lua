--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require("game.button")
Menu = {}
Menu.__index = Menu

function Menu:new()
    local self = {}
    setmetatable(self,Menu)
    self.font = love.graphics.newImage(ImgDirectory.."menuBackground.jpg")
    local options = {x =200,y = 200,sizex=100,sizey=100}
    self.buttonTut = Button:new(options)
    local options = {x =200,y = 200,sizex=100,sizey=100}
	local options2 = {x =400,y = 200,sizex=100,sizey=100}
    self.buttonGP = Button:new(options2)
    return self
end

function Menu:mousePressed(x, y, button)
	print(x,y)
	self.buttonTut:mousePressed(x, y)
	self.buttonGP:mousePressed(x, y)
end

function Menu:mouseReleased(x, y, button)
	if self.buttonTut:askReleased(x, y) then
		gameState:changeState('Tutorial')
	elseif self.buttonGP:askReleased(x, y) then
		gameState:changeState('Gameplay')
	end
end

function Menu:keyPressed(key, unicode)
end

function Menu:keyReleased(key, unicode)
end

function Menu:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function Menu:draw()
	love.graphics.draw(self.font,0,0)
	self.buttonTut:draw()
	self.buttonGP:draw()
end
