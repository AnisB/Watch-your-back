--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

HighScore = {}
HighScore.__index = HighScore
function HighScore:new()
    local self = {}
    setmetatable(self, HighScore)
    return self
end

function HighScore:mousePressed(x, y, button)

end

function HighScore:mouseReleased(x, y, button)

end

function HighScore:keyPressed(key, unicode)
	
end

function HighScore:keyReleased(key, unicode)

end

function HighScore:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function HighScore.draw()

end
