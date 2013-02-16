--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Environment = {}
Environment.__index = Environment

function Environment:new(gameplay)
	self.gp = gameplay
	local self = {}
	setmetatable(self, Environment)

	self.platform = love.graphics.newImage("platform.jpg")
	--the background for our scene
	self.scene = love.graphics.newImage("bg.png")
	-- the character we will be moving around
	self.person = love.graphics.newImage("dude.jpg")
	-- an object to move around
	self.object = love.graphics.newImage("ball.jpg")


	-- the character position
	self.character = {400,400} -- x,y

	-- a bunch of objects, each with a position
	self.objects = {}
	self.objects[1] = {550,370}
	self.objects[2] = {220,390}
	self.objects[3] = {600,410}
	self.objects[4] = {300,450}
	self.objects[5] = {400,530}

	return self
end

function Environment:mousePressed(x, y, button)

end

function Environment:mouseReleased(x, y, button)

end

function Environment:keyPressed(key, unicode)
	
end

function Environment:keyReleased(key, unicode)

end

function Environment:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
end

function Environment:draw()


	local drawn = false -- true when the character has been drawn

	for i,v in ipairs(self.objects) do
		if not drawn and self.objects[i][2] > self.character[2] then
			love.graphics.draw(self.person, self.character[1] - self.person:getWidth()/2-self.gp.scrolledDistance, self.character[2] - self.person:getHeight())
			drawn = true
		end
		love.graphics.draw(self.object, self.objects[i][1] - self.object:getWidth()/2-self.gp.scrolledDistance, self.objects[i][2] - self.object:getHeight())
	end

	if not drawn then -- if the self.person is below all self.objects it won't be drawn within the for loop
		love.graphics.draw(self.person, self.character[1] - self.person:getWidth()/2, self.character[2] - self.person:getHeight())
	end

	-- any foreground objects go here
end

function Environment.test()
	print('test')
end