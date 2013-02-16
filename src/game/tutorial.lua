--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Tutorial = {}
Tutorial.__index =  Tutorial
function Tutorial:new()
    local self = {}
    setmetatable(self,Tutorial)
    return self
end

function Tutorial:mousePressed(x, y, button)

end

function Tutorial:mouseReleased(x, y, button)

end

function Tutorial:keyPressed(key, unicode)
	
end

function Tutorial:keyReleased(key, unicode)

end

function Tutorial:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function Tutorial.draw()

end
