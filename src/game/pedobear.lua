--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]



Pedobear = {}
Pedobear.__index = Pedobear


function Pedobear:new(platforms, imageSet, scrollOffset)
	local self = {}
	setmetatable(self, Pedobear)
    self.pedo = love.graphics.newImage(ImgDirectory.."pedobear.png")
	return self
end

function Pedobear:update(dt)

end

function Pedobear:draw()
	love.graphics.draw(self.pedo,-180,-20)
end

