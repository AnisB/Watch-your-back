require 'anim'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.X_COEFF = 1  -- position to pixel (x)
Boy.Y_COEFF = 1 -- position to pixel (y)

function Boy.new()
	local self = {}
	setmetatable(self, Boy)
	-- >>>>> Initialisation des attributs :
	self.img = love.graphics.newImage("me.png")
	self.pos = {x = 100, y = 300}
	self.vit = {x = 0, y = 0}
	self.state = "running"
	self.anim = Anim.new('boy')
	-- >>>>> Initialisation end
	return self
end

function Boy:applyForce(x, y)
	-- theo work here
end

function Boy:getPos()
	-- theo work here
	-- return x, y
end

function Boy:loadAnimation(anim, force)
	self.anim:load(anim, force)
end

function Boy:update(seconds)
	self.anim:update(seconds)
end

function Boy:draw()
	x_calc = self.pos.x * Boy.X_COEFF
	y_calc = self.pos.y * Boy.Y_COEFF
	love.graphics.draw(self.anim:getSprite(), x_calc, y_calc)
end