--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.environment")

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)

	self.environment = Environment:new()

	return self
end

function Gameplay:mousePressed(x, y, button)

end

function Gameplay:mouseReleased(x, y, button)

end

function Gameplay:keyPressed(key, unicode)
	
end

function Gameplay:keyReleased(key, unicode)

end

function Gameplay:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
	self.environment:update(dt)
end

function Gameplay:draw()
	self.environment:draw()
end

function Gameplay.test()
end