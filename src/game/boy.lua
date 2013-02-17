require 'game/anim'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.INIT_X = 100
Boy.INIT_Y = 300

stdSpeed = 0
goRightSpeed = 140
goLeftSpeed = -100
stdUpForce = -20

-- Those are used to calibrate the actual sprite display with respect 
JUMP_IMPULSE = -130
drawingOffsetX = 0
drawingOffsetY = 0
JUMP_SAFE_DELAY = 0.09

function Boy.new(gameplay)
	local self = {}
	setmetatable(self, Boy)
	-- >>>>> Initialisation des attributs :
	self.gp = gameplay
	self.pos = {x = 700, y = 300}
	self.w = 110
	self.h = 155
	-- self.r = 90
	self.speed = {x = stdSpeed, y = stdUpForce}
	self.state = "running"
	self.anim = Anim.new('boy')
	self.mode = "r"
	self.jumpTimer = 0

	-- Physics Component (pc)
	if self.mode == "c" then
		drawingOffsetX = -45
		drawingOffsetY = -52

		self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.C, self.pos.x, self.pos.y, false, {r=self.r})
	else
		drawingOffsetX = -115
		drawingOffsetY = -105

		self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.R, self.pos.x, self.pos.y, false, {width=self.w, height=self.h})
	end
	self.pc.body:setLinearDamping(0.3)
	self.pc.body:setMass(0.15)
	self.pc.fixture:setFriction(0.7)
	self.pc.fixture:setRestitution(0.0) --let the PhysicsComponent bounce
	self.pc.fixture:setUserData(self)
	-- >>>>> Initialisation end
	
	self.flyingEnabled = false
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

	if self.state ~= "jumping" and self.jumpTimer >= JUMP_SAFE_DELAY then
		self.jumpTimer = 0
		self.pc.body:applyLinearImpulse(0, JUMP_IMPULSE)
		self.state = "jumping"
		if self.teleportEnabled or self.flyingEnabled then
		else
		self:loadAnimation("startjumping",true)
		end
		self.loopJump=true
	end
end

function Boy:getSpeed(  )
	return self.pc.body:getLinearVelocity()
end

function Boy:collideWith( object, collision )
	if object.name == "paltform" then
		print "Colliding with a paltform"
		local x, y = self:getPosition()
		local x2, y2 = object:getPosition()
		if y <= y2 then
			self.state = "running"
		end
	end
	if self.loopJump then
		self:loadAnimation("landing",true)
		self.loopJump=false
	end
	-- print ("Colliding with", tostring(object))
	if self.loopJump and not self.teleportEnabled and not self.flyingEnabled then
		self:loadAnimation("landing",true)
		self.loopJump=false
	end

end

function Boy:unCollideWith( object, collision )
	if self.loopJump and not self.teleportEnabled and not self.flyingEnabled then
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
		self:loadAnimation('teleport',true)
		Sound.playMusic('themetele')
	else
		self:loadAnimation('running',true)
		Sound.playMusic('themeprincipal')

	end
	self.teleportEnabled= value
end

function Boy:enableFlying(value)
	if value then
		Sound.playMusic('themevol')
	else
		Sound.playMusic('themeprincipal')

	end
	self.flyingEnabled= value
end

function Boy:enableInvincible(enabled)
	if enabled then
		Sound.playMusic('themeinv')
		self.pc.fixture:setDensity(0.0)
	else
		self.pc.fixture:setDensity(1.0)
		Sound.playMusic('themeprincipal')
	end
	self.invincibleEnabled = enabled
end

function Boy:left( )
	self.speed.x = goLeftSpeed
end

function Boy:right(  )
	self.speed.x = goRightSpeed
end

-- Just an alias for getPosition()
function Boy:getPos()
	return self:getPosition()
end

function Boy:getPosition(  )
	return self.pc.body:getPosition()
end

function Boy:loadAnimation(anim, force)
	self.anim:load(anim, force)
end

function Boy:update(seconds)
	self.jumpTimer = self.jumpTimer + seconds
	self.pc.body:applyForce(self.speed.x, self.speed.y)
	self.anim:update(seconds)
	self.timeT = self.timeT-seconds
	if self.timeT <= 0 then
		self.isTeleporing = false
	end

end

function Boy:draw()
	local x, y = self:getPos()
	x = x - self.gp.scrolledDistance

	if self.mode == "c" then
		x = x - self.r/2 + drawingOffsetX
		y = y - self.r/2 + drawingOffsetY
	else
		x = x + drawingOffsetX
		y = y + drawingOffsetY
	end

    if ShowHitBoxes then
    	if self.mode == "c" then
	    	love.graphics.circle("fill", self.pc.body:getX(), self.pc.body:getY(), self.pc.shape:getRadius())
	    else
			love.graphics.rectangle("fill", self.pc.body:getX()-self.w/2, self.pc.body:getY()-self.h/2, self.w, self.h)
		end
	end
	if self.invincibleEnabled then
		love.graphics.draw(self.anim:getSprite(), x, y-140,0, 0.5,0.5)
		return
	end
	
	if self.teleportEnabled and self.isTeleporing then
		if 	self.animState then
			self.animState= not self.animState
			love.graphics.draw(self.teleport1, x, y,0, 0.25,0.25)
			return 
		else 
			love.graphics.draw(self.teleport1, x, y,0, 0.25,0.25)
			return
		end
	end
	
	love.graphics.draw(self.anim:getSprite(), x, y,0, 0.25,0.25)

end