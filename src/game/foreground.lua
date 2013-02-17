--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]

require('strict')


LN2 = math.log(2)


Foreground = {}
Foreground.__index = Foreground

function Foreground:new(r, g, b)
    local self = {}
    setmetatable(self, Foreground)

	self.r = r
	self.g = g
	self.b = b
	self.a = 0

	return self
end


function Foreground:setAlphaFromDangerLevel(dangerLevel)
	self.a = math.min(192, math.floor(192 * math.exp((dangerLevel/10 - 8) * LN2) / 1.5)) -- Augment in an exp way the red level when the player get to close to the pedobear
end


function Foreground:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.r, self.g, self.b, self.a)

	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	love.graphics.setColor(r, g, b, a)
end