require 'game/anim'
require 'game/sound'

Boy = {}
Boy.__index = Boy

Boy.RUN_COEFF = 1
Boy.JUMP_COEFF = 1
Boy.INIT_X = 100
Boy.INIT_Y = 300

stdSpeed = 0
goRightSpeed = 140
goLeftSpeed = -100
stdUpPulse = -4 -- beyond other, this is used to avoid rectangle hitbox-related bugs
goDownSpeed = 100
flyingUpSpeed = -100
jumpingGoLeftSpeed = goLeftSpeed * 0.5
jumpingGoRightSpeed = goRightSpeed * 0.5

-- Those are used to calibrate the actual sprite display with respect 
JUMP_IMPULSE = -110
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
	self.speed = {x = stdSpeed, y = 0.0}
	self.upPulse = stdUpPulse
	self:setState("running")
	self.anim = Anim.new('boy')
	self.mode = "r"
	self.jumpTimer = 0
	self.dtUpPulse = 0.0

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
	if self.state == "running" and self.jumpTimer >= JUMP_SAFE_DELAY then
		self.jumpTimer = 0
		self.pc.body:applyLinearImpulse(0, JUMP_IMPULSE)
		self:setState("jumping")
		self:loadAnimation("startjumping",true)
		self.loopJump=true
	elseif self.state == "flying" then
		self.speed.y = flyingUpSpeed
	end
end

function Boy:setState( state )
	-- print ("Changing state to " .. state)
	self.state = state
end
function Boy:getSpeed(  )
	return self.pc.body:getLinearVelocity()
end

function Boy:collideWith( object, collision )
	if object.bonus then
		-- print("WWAAAAAAAH A BONUS !!! =>", object.name)
		-- self.gp.playerState:enablePowerUp(object.name)
		self.gp.playerState:enablePowerUp(object.name)
		object:delete()
		if not object.details.malus then
			Sound.playSound("buff")
		else
			Sound.playSound("malus")
		end
		return
	end
	if object.name == "paltform" then
		print "Colliding with a paltform"
		if self.state == "jumping" then -- Are we able to reset the jumping state back to the running state ?
			local x, y = self:getPosition()
			local x2, y2 = object:getPosition()
			if y <= y2 then
				self:setState("running")
			end
		end
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
	self.speed.y = 0.0
end

function Boy:teleport( x,y )
	self.isTeleporing=true
	Sound.playSound("teleportation")
	self.timeT=0.15
	self.pc.body:setPosition(x,y)
end

function Boy:disableUpPulse(  )
	self.upPulse = 0.0
end

function Boy:enableUpPulse(  )
	self.upPulse = stdUpPulse
end

function Boy:enableTeleport(value)
	print "EN_TP"
	if value then
		self:loadAnimation('teleport',true)
		Sound.playMusic('themetele')
		self:setState("teleporting")
	else
		self:loadAnimation('running',true)
		Sound.playMusic('themeprincipal')
		self:setState("running")
	end
	self.teleportEnabled= value
end

function Boy:enableFlying(enabled)
	print "EN_FLY"
	if enabled then
		Sound.playMusic('themevol')
		self:loadAnimation('invincible',true)
		self.upPulse = 0
		self:setState("flying")
	else
		self:loadAnimation('running',true)
		Sound.playMusic('themeprincipal')
		self.upPulse = stdUpPulse
		self:setState("running")
	end
	self.flyingEnabled= enabled
end

function Boy:enableInvincible(enabled)
	print "EN_INV"

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
	if self.state == "jumping" then
		self.speed.x = jumpingGoLeftSpeed
	else
		self.speed.x = goLeftSpeed
	end
end

function Boy:right(  )
	if self.state == "jumping" then
		self.speed.x = jumpingGoRightSpeed
	else
		self.speed.x = goRightSpeed
	end
end

function Boy:down(  )
	self.speed.y = goDownSpeed
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
	self.dtUpPulse = self.dtUpPulse + seconds
	self.pc.body:applyForce(self.speed.x, self.speed.y)
	self.pc.body:applyLinearImpulse(0.0, 0.0)
	if self.dtUpPulse > 0.1 then
		self.dtUpPulse = 0.0
		self.pc.body:applyLinearImpulse(0.0, self.upPulse)
	end
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