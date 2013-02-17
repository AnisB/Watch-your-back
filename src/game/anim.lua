Anim = {}
Anim.__index = Anim

Anim.ANIMS = {  -- set of animations available :
	running = {},
	startjumping = {},
	jumping = {},
	falling = {},
	dying = {},
	landing ={},
	teleport={}
}

Anim.DELAY = 0.100  -- toutes les 200ms, on fait anim.next()

-- name
Anim.ANIMS.running.name = "running"
Anim.ANIMS.startjumping.name = "startjumping"
Anim.ANIMS.jumping.name = "jumping"
Anim.ANIMS.falling.name = "falling"
Anim.ANIMS.dying.name = "dying"
Anim.ANIMS.landing.name = "landing"
Anim.ANIMS.teleport.name = "teleport"

-- number of sprites :
Anim.ANIMS.running.number = 8
Anim.ANIMS.startjumping.number = 4
Anim.ANIMS.jumping.number = 4
Anim.ANIMS.falling.number = 8
Anim.ANIMS.dying.number = 8
Anim.ANIMS.landing.number = 3
Anim.ANIMS.teleport.number = 2

-- priority :
Anim.ANIMS.running.priority = 10
Anim.ANIMS.startjumping.priority = 20
Anim.ANIMS.jumping.priority = 20
Anim.ANIMS.falling.priority = 20
Anim.ANIMS.dying.priority = 30
Anim.ANIMS.landing.priority = 30
Anim.ANIMS.teleport.priority = 30

-- automatic loopings or automatic switch :
Anim.ANIMS.running.loop = true
Anim.ANIMS.startjumping.switch = Anim.ANIMS.jumping
Anim.ANIMS.jumping.loop = true
Anim.ANIMS.falling.loop = true
Anim.ANIMS.dying.endCallback = function() print("GAME OVER") end
Anim.ANIMS.landing.switch = Anim.ANIMS.running
Anim.ANIMS.teleport.loop = true


-- next anim available :
Anim.ANIMS.running.nexts = {
	Anim.ANIMS.running,
	Anim.ANIMS.startjumping,
	Anim.ANIMS.falling,
	Anim.ANIMS.dying,
}
Anim.ANIMS.startjumping.nexts = {
	Anim.ANIMS.jumping,
	Anim.ANIMS.dying
}
Anim.ANIMS.jumping.nexts = {
	Anim.ANIMS.falling,
	Anim.ANIMS.dying
}
Anim.ANIMS.falling.nexts = {
	Anim.ANIMS.running,
	Anim.ANIMS.dying
}


-- PUBLIC : constructor
function Anim.new(folder)
	local self = {}
	setmetatable(self, Anim)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(Anim.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'game/anim/'..folder..'/'..key..'/'..i..'.png'
			-- print("loading image =>", path)
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = Anim.ANIMS.running
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function Anim:getSprite()
	return self.currentImg
end

-- PUBLIC : change animation (you can force it)
function Anim:load(anim, force)
	local newAnim = Anim.ANIMS[anim]
	if force or newAnim.priority > self.currentAnim.priority then
		self.currentAnim = newAnim
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
		self:updateImg()
	else
		self.currentAnim.after = newAnim
	end
end

-- PUBLIC : update l'anim
function Anim:update(seconds)
	self.time = self.time + seconds
	if self.time > Anim.DELAY then
		self:next()
		self.time = self.time - Anim.DELAY
	end
end

-- PRIVATE : go to next sprite
function Anim:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.currentAnim.number then
		-- end of an animation
		if self.currentAnim.endCallback then
			self.currentAnim.endCallback()
		end
		if self.currentAnim.after ~= nil then
			self.currentAnim = self.currentAnim.after
		elseif self.currentAnim.switch ~= nil then
			self.currentAnim = self.currentAnim.switch
		elseif self.currentAnim.loop then
			-- I don't switch
		else
			print("FUCKING ANIM SWITCHING ERROR")
		end
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
	end
	self:updateImg()
end

-- PRIVATE
function Anim:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end