--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Gameplay = {}
Gameplay.__index = Gameplay

function Gameplay:new()
	local self = {}
	setmetatable(self, Gameplay)

	-- -- the background for our scene
	-- scene = love.graphics.newImage("room.png")
	-- -- the character we will be moving around
	-- person = love.graphics.newImage("guy.png")
	-- -- an object to move around
	-- object = love.graphics.newImage("ball.png")


	return self
end

function Gameplay:mousePressed(x, y, button)

end

function Gameplay:mouseReleased(x, y, button)

end

function Gameplay:keyPressed(key, unicode)
	
end

function Gameplay:keyReleased(key, unicode)

end

function Gameplay:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end
	print('bleh')

end

function Gameplay.draw()
	print('draw')

end

function Gameplay.test()
	print('test')
end