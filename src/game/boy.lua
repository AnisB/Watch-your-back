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
	self.state = "normal"  -- can be "normal", "jumping", "dead", ...
	-- >>>>> Initialisation end
	return self
end

function Boy:update(dt)
	self.pos.x += self.vit.x * Boy.RUN_COEFF
	self.pos.y += self.vit.y * Boy.JUMP_COEFF
end

function Boy:jump(val)
	self.pos.y = self.pos.y - val
end

function Boy:applyForce(x, y)
	-- theo work here
end

function Boy:getPos()
	-- theo work here
	-- return x, y
end

function Boy:loadAnimation(anim)

end

function Boy:draw()
	x_calc = self.pos.x * Boy.X_COEFF
	y_calc = self.pos.y * Boy.Y_COEFF
	love.graphics.draw(self.img, x_calc, y_calc)
end