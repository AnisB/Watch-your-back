Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1

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
end

function Boy:press(key)
end

function Boy:jump(val)
	self.pos.y = self.pos.y - val
end

function Boy:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y)
end