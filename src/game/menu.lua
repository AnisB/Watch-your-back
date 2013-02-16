--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Menu = {}
Menu.__index = Menu

function Menu:new()
    local self = {}
    setmetatable(self,Menu)
    self.font = love.graphics.newImage(ImgDirectory.."menuBackground.jpg")
    return self
end

function Menu:mousePressed(x, y, button)

end

function Menu:mouseReleased(x, y, button)

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
end
