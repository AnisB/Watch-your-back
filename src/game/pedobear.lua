--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('game.sound')

Pedobear = {}
Pedobear.__index = Pedobear


function Pedobear:new(platforms, imageSet, scrollOffset)
	local self = {}
	setmetatable(self, Pedobear)
    self.pedo = love.graphics.newImage(ImgDirectory.."pedobear.png")
    self.increase=true
    self.decrease=false
    self.counter=0
	return self
end

function Pedobear:update(dt)
	local b =math.random(1,1500)
	
	if(b ==2) then
		Sound.playSound('pedo')
	end
end

function Pedobear:draw()
	--bg = love.graphics.newImage.createEmpty(480,272 )
	--black = Color.new(0,0,0,120)
	if self.counter<=30  and self.increase then
		self.counter = self.counter+1
	elseif self.counter>0  and self.decrease then 
			self.counter = self.counter-1
	end
	if self.counter>=30 and self.increase then
		self.increase=false
		self.decrease=true
	end
	
	if self.counter<=0 and self.decrease then
		self.increase=true
		self.decrease=false
	end
	
	love.graphics.draw(self.pedo,-180+self.counter,-20)

end

