--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]


require("game.menu")
require("game.gameplay")
require("game.gameover")
require("game.tutorial")
require("game.highscore")

GameState = {}
GameState.__index = GameState

function GameState:new()
    local self = {}
    setmetatable(self, GameState)
	-- self.menu= Menu.new{}
	-- self.gameover= GameOver.new{}
	-- self.gameplay = Gameplay.new{}
	-- self.tutorial= Tutorial.new{}
	-- self.Highscore = HighScore.new{}
	state = {
        Menu      = Menu.new{},
        Tutorial  = Tutorial.new{},
        Gameplay  = Gameplay.new{},
        GameOver  = GameOver.new{},
        HighScore = HighScore.new{}
    }
	currentState='Gameplay'
	return self
end

function GameState:mousePressed(x, y, button)
    state[currentState]:mousePressed(x,y,button)
end

function GameState:mouseReleased(x, y, button)
	state[currentState]:mouseReleased(x,y,button)
end

function GameState:keyPressed(key, unicode)
	state[currentState]:draw(key, unicode)
end

function GameState:keyReleased(key, unicode)
	state[currentState]:keyReleased(key, unicode)
end

function GameState:update(dt)
    state[currentState]:update(dt)
end

function GameState:draw()	
    state[currentState]:draw()
end
