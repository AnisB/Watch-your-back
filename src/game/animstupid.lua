 
AnimStupid = {}
AnimStupid.__index = AnimStupid

--[[--

UTILISATION :
	
	tomate = truc(...)
	truc.anim = AnimStupid('tomato', 3)  -- directory 'tomato/', 3 PNG.
	[...]
	draw(truc.anim.getSprite())...
	tuc.anim.next()

--]]--

-- PUBLIC : constructor
function AnimStupid.new(folder, number)
	local self = {}
	setmetatable(self, AnimStupid)
	self.sprites = {}
	for i=1, number do
		local path = 'game/anim/'..folder..'/'..i..'.png'
		self.sprites[i] = love.graphics.newImage(path)
	end
	self.currentPos = 1
	self.number = number
	return self
end

-- PUBLIC : getter for the sprite
function AnimStupid:getSprite()
	return self.sprites[self.currentPos]
end

-- PUBLIC : go to next sprite
function AnimStupid:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.number then
		self.currentPos = 1
	end
end