--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]

require('strict')

Hud = {}
Hud.__index = Hud

function Hud:new(gameplay)
    local self = {}
    setmetatable(self, Hud)

	self.gp = gameplay

	return self
end

function Hud:draw()
	love.graphics.print(self.gp.scrolledDistance, 10, 10)
end
