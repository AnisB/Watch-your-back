--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require("game.platform")

PlatformSet = {}
PlatformSet.__index = PlatformSet

tileSize = 50
tileOffsetX = 20
tileOffsetY = 40

function PlatformSet:new(platforms, imageSet, scrollOffset)
	local self = {}
	setmetatable(self, PlatformSet)

	self.scrollOffset = scrollOffset
	self.imageSet = imageSet
	self.width = tileSize * #platforms[1]
	self.platforms = {}

	for y,platformLine in ipairs(platforms) do
		for x,platform in ipairs(platformLine) do
			if platform ~= 0 then
				table.insert(self.platforms, Platform:new(
					scrollOffset + (x-1)*tileSize - tileOffsetX, --minx
					(y-1)*tileSize - tileOffsetY, -- miny
					tileSize,
					imageSet[platform]
				))
			end
		end
	end

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

function PlatformSet:getWidth()
	return self.width
end

function PlatformSet:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

	for i,platform in ipairs(self.platforms) do
		platform:update(dt)
	end

end

function PlatformSet:draw(refIndex)
	for i,platform in ipairs(self.platforms) do
		platform:draw(refIndex)
	end
end

function PlatformSet:destroy()
	for x,platform in ipairs(platforms) do
		platform:destroy()
	end
end

