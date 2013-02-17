--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]

require("game.button")


Menu = {}
Menu.__index = Menu

function Menu:new()
    local self = {}
    setmetatable(self, Menu)

    self.background = love.graphics.newImage(ImgDirectory.."menubackground.png")
    local options = {x=675, y=250, sizex=240, sizey=80, unclickedb='unclickedb_tut.png', clickedb='clickedb_tut.png'}
    self.buttonTuto = Button:new(options)
    options = {x=675, y=330, sizex=240, sizey=80, unclickedb='unclickedb_gp.png', clickedb='clickedb_gp.png'}
    self.buttonGame = Button:new(options)

    return self
end


function Menu:mousePressed(x, y, button)
	-- print(x,y)
	self.buttonTuto:mousePressed(x, y)
	self.buttonGame:mousePressed(x, y)
end

function Menu:mouseReleased(x, y, button)
	if self.buttonTuto:askReleased(x, y) then
		gameState:changeState('Tutorial')
	elseif self.buttonGame:askReleased(x, y) then
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
	love.graphics.draw(self.background, 0, 0)
	self.buttonTuto:draw()
	self.buttonGame:draw()
end