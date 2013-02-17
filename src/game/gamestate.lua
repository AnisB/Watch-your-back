--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]


require("game.menu")
require("game.gameplay")
require("game.gameover")
require("game.tutorial")
require("game.highscore")
require("game.sound")

GameState = {}
GameState.__index = GameState

function GameState:new()
    local self = {}
    setmetatable(self, GameState)
	self.state = {}
    self.state['Menu']      = Menu.new()
    self.state['Tutorial']  = Tutorial.new()
    self.state['Gameplay']  = Gameplay.new()
    self.state['GameOver']  = GameOver.new(self.Gameplay)
    self.state['HighScore'] = HighScore.new()
    self.currentState='Menu'
    Sound.playMusic("berceuse")
	return self
end

function GameState:mousePressed(x, y, button)
    self.state[self.currentState]:mousePressed(x,y,button)
end

function GameState:mouseReleased(x, y, button)
	self.state[self.currentState]:mouseReleased(x,y,button)
end

function GameState:keyPressed(key, unicode)
	self.state[self.currentState]:keyPressed(key, unicode)
end

function GameState:keyReleased(key, unicode)
	self.state[self.currentState]:keyReleased(key, unicode)
end

function GameState:update(dt)
    self.state[self.currentState]:update(dt)
end

function GameState:draw()	
    self.state[self.currentState]:draw()
end

function GameState:changeState(newState)
	self.currentState= newState
end
