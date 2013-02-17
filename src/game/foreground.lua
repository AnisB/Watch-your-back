--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]

require('strict')


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
	self.a = math.floor(190 * dangerLevel / 100)
end


function Foreground:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.r, self.g, self.b, self.a)

	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	love.graphics.setColor(r, g, b, a)
end