require 'game/anim'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.INIT_X = 100
Boy.INIT_Y = 300

stdSpeed = 0
fasterSpeed = 120
slowerSpeed = -100

-- Those are used to calibrate the actual sprite display with respect 
drawingOffsetX = -45
drawingOffsetY = -52

function Boy.new(gameplay)
	local self = {}
	setmetatable(self, Boy)
	-- >>>>> Initialisation des attributs :
	self.gp = gameplay
	self.pos = {x = 700, y = 300}
	-- self.w = 50
	-- self.h = 220
	self.r = 90
	self.speed = {x = stdSpeed, y = 0}
	self.state = "running"
	self.anim = Anim.new('boy')

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.C, self.pos.x, self.pos.y, false, {r=self.r})
	self.pc.body:setLinearDamping(0.1)
	self.pc.body:setMass(0.15)
	self.pc.fixture:setFriction(0.0)
	self.pc.fixture:setRestitution(0.0) --let the PhysicsComponent bounce
	self.pc.fixture:setUserData(self)
	-- >>>>> Initialisation end
	return self
end

function Boy:jump()
	if self.state ~= "jumping" then
		self.pc.body:applyLinearImpulse(0, -100)
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
	-- local x, y = object:getPosition()
	-- print ("Colliding with ", tostring(object.name), x, y)
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
	love.graphics.draw(self.anim:getSprite(), x - self.r/2 + drawingOffsetX, y - self.r/2 + drawingOffsetY, 0, 0.1,0.1)

	-- love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
 --  love.graphics.circle("fill", self.pc.body:getX(), self.pc.body:getY(), self.pc.shape:getRadius())
end