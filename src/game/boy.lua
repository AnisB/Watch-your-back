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
	self.w = 20
	self.h = 50
	self.speed = {x = stdSpeed, y = 0}
	self.state = "running"
	self.anim = Anim.new('boy')

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.R, self.pos.x, self.pos.y, false, {width=self.w, height=self.h})
	self.pc.body:setLinearDamping(0.9)
	self.pc.fixture:setFriction(0.0)
	self.pc.fixture:setRestitution(0.0) --let the PhysicsComponent bounce
	self.pc.fixture:setUserData(self)
	-- >>>>> Initialisation end
	
	
	self.teleportEnabled=false
	self.loopJump=false
	self.isTeleporing=false
	self.timeT=0
	self.animState=true
	
	self.teleport1 = love.graphics.newImage(ImgDirectory.."teleport/teleport1.png")
	self.teleport2 = love.graphics.newImage(ImgDirectory.."teleport/teleport2.png")
	return self
end

function Boy:jump()
	if self.state ~= "jumping" then
		self.pc.body:applyLinearImpulse(0, -200)
		self.state = "jumping"
		self:loadAnimation("startjumping",true)
		self.loopJump=true
	end
end

function Boy:collideWith( object, collision )
	if object.name == "paltform" then
		self.state = "running"
	end
	-- print ("Colliding with", tostring(object))
		if self.loopJump then
			self:loadAnimation("landing",true)
			self.loopJump=false
		end

end

function Boy:unCollideWith( object, collision )
		if self.loopJump then
			self:loadAnimation("landing",true)
			self.loopJump=false

		end
end

function Boy:still(  )
	self.speed.x = stdSpeed
end

function Boy:teleport( x,y )
	self.isTeleporing=true
	self.timeT=0.15
	self.pc.body:setPosition(x,y)
end

function Boy:enableTeleport(value)
	if value then
		Sound.playMusic('themetele')
	else
		Sound.playMusic('themeprincipal')

	end
	self.teleportEnabled= value
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
	self.timeT= self.timeT-seconds
	if self.timeT<=0 then
		self.isTeleporing=false
	end

end

function Boy:draw()
	local x, y = self:getPos()
	x = x - self.gp.scrolledDistance
	-- print ("boyX=", x)
	-- print ("scroll=", self.gp.scrolledDistance)
	-- print ("Boy is currently at x, y = ", x, y)
	love.graphics.draw(self.anim:getSprite(), x, y-130,0, 0.1,0.1)
	
	if self.teleportEnabled and self.isTeleporing then
		if 	self.animState then
			self.animState= not self.animState
			love.graphics.draw(self.teleport1, x, y-130,0, 0.1,0.1)
		else
			love.graphics.draw(self.teleport1, x, y-130,0, 0.1,0.1)
		end
	end
end