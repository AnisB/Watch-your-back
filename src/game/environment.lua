--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require("game.platform_set")


Environment = {}
Environment.__index = Environment

function Environment:new(gameplay)
	self.gp = gameplay
	local self = {}
	setmetatable(self, Environment)

	self.platformBufferC = PlatformSet.new(1, self.gp.scrolledDistance)

	self.myScrooled =0
	self.cx= 0 -- cx = Current X
	self.nx=1100 -- nx = Next X
	self.nextPL = 2
	self.currentPL = 1
	
	self.done =false
	self.done2 = false
	return self
end

function Environment:mousePressed(x, y, button)

end

function Environment:mouseReleased(x, y, button)

end

function Environment:keyPressed(key, unicode)
	
end

function Environment:keyReleased(key, unicode)

end

function Environment:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
		
	self.myScrolled=self.gp.scrolledDistance
	if math.floor((self.myScrolled+1024)%1100)>0 and math.floor((self.myScrolled+1024)%1100)<5  then
		self.drawNext=true
		self.nx=self.cx+1100
		self.nextPL=math.random(1, PlatformSet.getNbSets())
		self.platformBufferN =PlatformSet.new(self.nextPL, self.gp.scrolledDistance+1100)
		
	end
	if math.abs((math.floor(self.nx)-math.floor(self.myScrolled)))<5  then
		self.drawNext=false
		self.cx=self.nx
		self.currentBg=self.nextBg
		--self.platformBufferC:destroy()--
		self.platformBufferC =self.platformBufferN
	end
end

function Environment:draw()
	-- Platforms
			self.platformBufferC:draw(self.gp.scrolledDistance)
		if self.drawNext then
			self.platformBufferN:draw(self.gp.scrolledDistance)
		end
end


function Environment.loadTileSet()
	tilesetImage = love.graphics.newImage( "tileset.png" )
	tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
	local tileSize = 50
	
	-- grass
	tileQuads[0] = love.graphics.newQuad(0 * tileSize, 20 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- kitchen floor tile
	tileQuads[1] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- parquet flooring
	tileQuads[2] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- middle of red carpet
	tileQuads[3] = love.graphics.newQuad(3 * tileSize, 9 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())

	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)
end