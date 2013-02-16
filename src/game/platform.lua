--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Platform = {}
Platform.__index = Platform

function Platform.new(minx, miny, tileSize, sprite)
	local self = {}
	setmetatable(self, Platform)

	self.sprite = sprite
	self.tileSize = tileSize
	self.minx = minx
	self.miny = miny

	return self
end

function Platform:mousePressed(x, y, button)

end

function Platform:mouseReleased(x, y, button)

end

function Platform:keyPressed(key, unicode)
	
end

function Platform:keyReleased(key, unicode)

end

function Platform:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
end

function Platform:draw(refIndex)
	local x,y = self:getPosition()
	love.graphics.draw(self.sprite, x - refIndex, y)
end

function Platform:getPosition()
	return self.minx,self.miny
end

function Platform:destroy()
	-- TODO Theo
end

