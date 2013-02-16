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
	self.state = {
        Menu      = Menu.new{},
        Tutorial  = Tutorial.new{},
        Gameplay  = Gameplay.new{},
        GameOver  = GameOver.new{},
        HighScore = HighScore.new{}
    }
	self.currentState='Menu'
	return self
end

function GameState:mousePressed(x, y, button)
    self.state[self.currentState]:mousePressed(x,y,button)
end

function GameState:mouseReleased(x, y, button)
	self.state[self.currentState]:mouseReleased(x,y,button)
end

function GameState:keyPressed(key, unicode)
	self.state[self.currentState]:draw(key, unicode)
end

function GameState:keyReleased(key, unicode)
	self.state[self.currentState]:keyReleased(key, unicode)
end

function GameState:update(dt)
    print('GS:update')
    self.state[self.currentState]:update(dt)
end

function GameState:draw()	
    self.state[self.currentState]:draw()
end

function GameState:changeState(newState)
	self.currentState= newState
end
