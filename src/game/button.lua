--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Button = {}
Button.__index =  Button
function Button:new(options)
    local self = {}
    setmetatable(self,Button)
    self.posx=options.x
    self.posy=options.y
    self.sizex=options.sizex
    self.sizey=options.sizey
    self.cx=0
    self.cy=0
    self.unclicked = love.graphics.newImage(ImgDirectory.."uclickedb.jpg")
    self.clicked = love.graphics.newImage(ImgDirectory.."clickedb.jpg")
    self.isclicked=false
    return self
end

function Button:mousePressed(x, y)
	if x>self.posx and y>self.posy and x<(self.posx+self.sizex) and y<(self.posy+self.sizey) then
		self.cx=x
		self.cy=y
		self.isclicked=true
	end
end

function Button:askReleased(x, y)
	print(self.cx)
	print(self.cy)
	self.isclicked=false
	if self.cx==x and self.cy==y then 
		return true
	else
		return false
	end
end


function Button:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function Button:draw()
	if self.isclicked then
		love.graphics.draw(self.unclicked,self.posx,self.posy)
	else
		love.graphics.draw(self.clicked,self.posx,self.posy)
	end
end
