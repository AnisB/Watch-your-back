--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Gameplay = {}
Gameplay.__index = Gameplay
function Gameplay:new()
    local self = {}
    setmetatable(self, Gameplay)
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

end

function Gameplay.draw()

end
