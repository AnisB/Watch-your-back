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
	print ("Creating a new platform bloc at x=", minx)
	self.minx = minx
	self.miny = miny
	self.name = "paltform"

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.R, minx, miny, true, {width=tileSize, height=tileSize})
	self.pc.fixture:setUserData(self)
	self.pc.fixture:setFriction(0.0)

	return self
end


function Platform:collideWith( object, collision )
end

function Platform:unCollideWith( object, collision )
	-- body
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

