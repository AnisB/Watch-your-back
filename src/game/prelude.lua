--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]


Prelude = {}
Prelude.__index = Prelude

function Prelude:new()
    local self = {}
    setmetatable(self, Prelude)
    self.timer = 12
    return self
end


function Prelude:mousePressed(x, y, button)

end

function Prelude:mouseReleased(x, y, button)
end

function Prelude:keyPressed(key, unicode)
	if key == "return" then
		gameState:changeState('Storyline')
	end
end

function Prelude:keyReleased(key, unicode)
end



function Prelude:update(dt)
	self.timer = self.timer-dt
	if self.timer <=0 then
		gameState:changeState('Storyline')
	end
end

function Prelude:draw()
	love.graphics.printf("Ce jeu a été réalisé pendant une édition de l'évènement de développement de jeux vidéo Game Rush, organisé par l'assiciation étudiant de l'INSA de Lyon JeuxVidéo@INSA", 300, 100, 400, "center")
		love.graphics.printf("L'humour utilisé dans ce jeu est à prendre au second degré, aucune drogue n'a été consommée pendant ou avant sa réalisation.", 300, 175, 400, "center")
				love.graphics.printf("L'équipe était composée de Pierre Germain(Graphisme), Valentin Machado(Son) et Anis Benyoub, Théo Dubourg, Frédéric Matigot, Nicolas Dossou-Gbété et Nechepso(Developpement).", 300, 250, 400, "center")
end