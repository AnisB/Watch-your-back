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
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 255, 0, 255)

	love.graphics.print(self.gp.playerState:getScore(), 10, 10)

	love.graphics.setColor(r, g, b, a)
end