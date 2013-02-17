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
	self.figures = {love.graphics.newImage(ImgDirectory..'chiffre0.png'),
		love.graphics.newImage(ImgDirectory..'chiffre1.png'),
		love.graphics.newImage(ImgDirectory..'chiffre2.png'),
		love.graphics.newImage(ImgDirectory..'chiffre3.png'),
		love.graphics.newImage(ImgDirectory..'chiffre4.png'),
		love.graphics.newImage(ImgDirectory..'chiffre5.png'),
		love.graphics.newImage(ImgDirectory..'chiffre6.png'),
		love.graphics.newImage(ImgDirectory..'chiffre7.png'),
		love.graphics.newImage(ImgDirectory..'chiffre8.png'),
		love.graphics.newImage(ImgDirectory..'chiffre9.png')
	}
	self.scoreImage = love.graphics.newImage(ImgDirectory..'score.png')
	self.figureWidth = 36
	self.hudColor = {r=0, g=255, b=0, a=255}
	self.scoreWidth = 178
	self.scoreSize = 10

	return self
end


function Hud:draw()
	local function format(score)
		local scoreFigures = {}
		while score > 0 do
			table.insert(scoreFigures, 0, self.figures[score%10+1])
			score = math.floor(score/10)
		end
		while #scoreFigures < self.scoreSize do
			table.insert(scoreFigures, 0, self.figures[1])
		end
		return scoreFigures
	end

	local function display(scoreFigures, x, y)
		for idx = 1, #scoreFigures do
			love.graphics.draw(scoreFigures[idx], x, y)
			x = x+self.figureWidth
		end
	end

	love.graphics.draw(self.scoreImage, 10, 10)
	display(format(self.gp.playerState:getScore()), 10+self.scoreWidth, 10)
end