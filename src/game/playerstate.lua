--[[
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso

This class handles everything related to current state of the player: hp, number of lifes 
]]

require('strict')


PLAYERSTATE_LIFES = 3        -- Number of lifes remaining at the beginning of a new game (integer)
PLAYERSTATE_MAX_HP = 100     -- Maximum health of the player (integer)


PlayerState = {}
PlayerState.__index = PlayerState

function PlayerState:new(gameplay)
    local self = {}
    setmetatable(self, PlayerState)

	self.gp = gameplay
	self.currentPowerUp = nil
	self.hp = 100 -- TODO: Use the conf variable `t.gameplay.max_hp' instead
	self.lifes = 3 -- TODO: Use the conf variable `t.gameplay.lifes' instead
	self.score = 0

	return self
end


function PlayerState:killPlayer()
	self.currentPowerUp = nil
	self.hp = 0
end

function PlayerState:useNextLife()
	self.lifes = self.lifes - 1
	self.hp = 100 -- TODO: Use the conf variable `t.gameplay.max_hp' instead
end

function PlayerState:updateScore()
	self.score = self.gp.scrolledDistance
end

function PlayerState:update()
	self:updateScore()
end