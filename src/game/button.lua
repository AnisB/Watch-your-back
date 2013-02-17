--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis et Nechepso
]]


Button = {}
Button.__index =  Button

function Button:new(options)
    local self = {}
    setmetatable(self, Button)

    self.posx = options.x
    self.posy = options.y
    self.sizex = options.sizex
    self.sizey = options.sizey
    self.unclicked = love.graphics.newImage(ImgDirectory..options.unclickedb)
    self.clicked = love.graphics.newImage(ImgDirectory..options.clickedb)
    self.isclicked = false

    return self
end


function Button:mousePressed(x, y)
	if x > self.posx and y > self.posy and x < self.posx+self.sizex and y < self.posy+self.sizey then
		self.isclicked = true
	end
end


function Button:askReleased(x, y)
	-- print(self.cx)
	-- print(self.cy)
	self.isclicked = false
	return x > self.posx and y > self.posy and x < self.posx+self.sizex and y < self.posy+self.sizey
end


function Button:update(dt)
end


function Button:draw()
	if self.isclicked then
		love.graphics.draw(self.clicked, self.posx, self.posy)
	else
		love.graphics.draw(self.unclicked, self.posx, self.posy)
	end
end