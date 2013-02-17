--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]

require("game.button")


Tutorial = {}
Tutorial.__index = Tutorial

function Tutorial:new()
    local self = {}
    setmetatable(self, Tutorial)

    self.background = love.graphics.newImage(ImgDirectory.."tutobackground.png")
    local options = {x=675, y=120, sizex=240, sizey=80, unclickedb='unclickedb_menu.png', clickedb='clickedb_menu.png'}
    self.buttonMenu = Button:new(options)

    return self
end


function Tutorial:mousePressed(x, y, button)
	-- print(x,y)
	self.buttonMenu:mousePressed(x, y)
end

function Tutorial:mouseReleased(x, y, button)
	if self.buttonMenu:askReleased(x, y) then
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
	love.graphics.draw(self.background, 0, 0)
	self.buttonMenu:draw()
end