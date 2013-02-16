--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

PlatformSet = {}
PlatformSet.__index = PlatformSet

tileSize = 50
tileOffsetX = 20
tileOffsetY = 40

function PlatformSet:new(platforms, imageSet)
	local self = {}
	setmetatable(self, PlatformSet)
	self.platforms = platforms
	print(self.platforms[1])
	self.imageSet = imageSet

	return self
end

function PlatformSet:mousePressed(x, y, button)

end

function PlatformSet:mouseReleased(x, y, button)

end

function PlatformSet:keyPressed(key, unicode)
	
end

function PlatformSet:keyReleased(key, unicode)

end

function PlatformSet:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
end

function PlatformSet:draw()
	for y,platformLine in ipairs(self.platforms) do
		for x,platform in ipairs(platformLine) do
			if platform ~= 0 then
				print(x .. ' '..y .. ':' .. x*tileSize .. ' ' .. y*tileSize)
				love.graphics.draw(self.imageSet[platform], (x-1)*tileSize - tileOffsetX, (y-1)*tileSize - tileOffsetY)
			end
		end
	end

end

