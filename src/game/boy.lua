require 'game/anim'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.INIT_X = 100
Boy.INIT_Y = 300

stdSpeed = 100
fasterSpeed = 150
slowerSpeed = 50

function Boy.new()
	local self = {}
	setmetatable(self, Boy)
	-- >>>>> Initialisation des attributs :
	self.pos = {x = 100, y = 300}
	self.w = 20
	self.h = 50
	self.speed = {x = stdSpeed, y = 0}
	self.state = "running"
	self.anim = Anim.new('boy')

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.R, self.pos.x, self.pos.y, false, {width=self.w, height=self.h})
	self.pc.body:setLinearDamping(0.9)
	self.pc.fixture:setRestitution(0.8) --let the PhysicsComponent bounce
	-- >>>>> Initialisation end
	return self
end

function Boy:jump()
	if self.state ~= "jumping" then
		self.pc.body:applyLinearImpulse(0, -140)
		self.state = "jumping"
	end
end

function Boy:left( )
	self.speed.x = slowerSpeed
end

function Boy:right(  )
	self.speed.x = fasterSpeed
end

function Boy:applyForce(x, y)
	-- theo work here
end

function Boy:getPos()
	return self.pc.body:getPosition()
end

function Boy:loadAnimation(anim, force)
	self.anim:load(anim, force)
end

function Boy:update(seconds)
	self.pc.body:applyForce(self.speed.x, 0)
	self.anim:update(seconds)
end

function Boy:draw()
	local x, y = self:getPos()
	-- print ("Boy is currently at x, y = ", x, y)
	love.graphics.draw(self.anim:getSprite(), x, y)
end