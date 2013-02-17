require 'game/animstupid'

Bonus = {}
Bonus.__index = Bonus

Bonus.ANIMS = {
	flying = {number = 2, interval = 0.3, live = 10, name = "flying"},
	invincible = {number = 1, interval = 0.3, live = 10, name = "invincible"},
	teleport = {number = 2, interval = 0.3, live = 10, name = "teleport"}
}

Bonus.NUMANIMS = {}
for key,val in pairs(Bonus.ANIMS) do
	table.insert(Bonus.NUMANIMS, val)
end

function Bonus.new(gameplay, bonuses, name)
	local self = {}
	setmetatable(self, Bonus)
	-- >>>>> Initialisation des attributs :
	self.gp = gameplay
	self.bonuses = bonuses

	self.pos = {x = 800 + self.gp.scrolledDistance, y = 100}
	self.w = 36
	self.h = 36
	self.bonus = true
	self.name = name
	self.anim = AnimStupid.new(name, Bonus.ANIMS[name].number)

	-- Physics Component (pc)
	self.pc = PhysicsComponent.new(PhysicsComponent.ShapeType.R, self.pos.x, self.pos.y, false, {width=self.w, height=self.h})
	self.pc.body:setLinearDamping(0.5)
	self.pc.fixture:setFriction(0.0)
	self.pc.fixture:setRestitution(0.0) --let the PhysicsComponent bounce
	self.pc.fixture:setUserData(self)
	-- >>>>> Initialisation end

	self.update_cronid = self.gp.cron.every(Bonus.ANIMS[name].interval, function()
		self.anim:next()
	end)

	self.delete_cronid = self.gp.cron.after(Bonus.ANIMS[name].live, function()
		self:delete()
	end)

	table.insert(self.bonuses, self)

	return self
end

function Bonus:delete()
	self.gp.cron.cancel(self.update_cronid)
	self.gp.cron.cancel(self.delete_cronid)
	for i=1, #self.bonuses do
		if self.bonuses[i] == self then
			table.remove(self.bonuses, i)
			return
		end
	end
end

function Bonus:draw()
	local spr = self.anim:getSprite()
	local x, y = self.pc.body:getPosition()
	x = x - self.gp.scrolledDistance
	love.graphics.draw(spr, x, y)
end

function Bonus:getSpeed()
	return self.pc.body:getLinearVelocity()
end

function Bonus:collideWith(object, collision)
end

function Bonus:unCollideWith(object, collision)
end
