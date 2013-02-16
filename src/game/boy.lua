require 'game/anim'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.INIT_X = 100
Boy.INIT_Y = 300

stdSpeed = 0
fasterSpeed = 100
slowerSpeed = -70

function Boy.new(gameplay)
	local self = {}
	setmetatable(self, Boy)
	-- >>>>> Initialisation des attributs :
	self.gp = gameplay
	self.pos = {x = 700, y = 300}
	-- self.w = 20
	-- self.h = 50
	self.r = 60
	self.speed = {x = stdSpeed, y = 0}
	self.state = "running"
	self.anim = Anim.new('boy')

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.C, self.pos.x, self.pos.y, false, {r=self.r})
	self.pc.body:setLinearDamping(0.5)
	self.pc.fixture:setFriction(0.0)
	self.pc.fixture:setRestitution(0.0) --let the PhysicsComponent bounce
	self.pc.fixture:setUserData(self)
	-- >>>>> Initialisation end
	return self
end

function Boy:jump()
	if self.state ~= "jumping" then
		self.pc.body:applyLinearImpulse(0, -200)
		self.state = "jumping"
	end
end

function Boy:getSpeed(  )
	return self.pc.body:getLinearVelocity()
end

function Boy:collideWith( object, collision )
	if object.name == "paltform" then
		self.state = "running"
	end
	local x, y = object:getPosition()
	print ("Colliding with ", tostring(object.name), x, y)
end

function Boy:unCollideWith( object, collision )
	-- body
end

function Boy:still(  )
	self.speed.x = stdSpeed
end

function Boy:left( )
	self.speed.x = slowerSpeed
end

function Boy:right(  )
	self.speed.x = fasterSpeed
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
	x = x - self.gp.scrolledDistance
	-- print ("boyX=", x)
	-- print ("scroll=", self.gp.scrolledDistance)
	-- print ("Boy is currently at x, y = ", x, y)
	love.graphics.draw(self.anim:getSprite(), x, y-70,0, 0.1,0.1)
end