--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Background = {}
Background.__index =  Background
function Background:new()
    local self = {}
    setmetatable(self,Background)
    self.backs ={first = ImgDirectory.."firstbg.jpg", second = ImgDirectory.."secondbg.jpg",third = "thirdbg.jpg"}
    self.isclicked=false
    return self
end

function Background:mousePressed(x, y)
	if x>self.posx and y>self.posy and x<(self.posx+self.sizex) and y<(self.posy+self.sizey) then
		self.cx=x
		self.cy=y
		self.isclicked=true
	end
end

function Background:askReleased(x, y)
	print(self.cx)
	print(self.cy)
	self.isclicked=false
	if self.cx==x and self.cy==y then 
		return true
	else
		return false
	end
end


function Background:update(dt)
	if dt > 0.1 then
		dt = 0.1
	end

end

function Background:draw()
	if self.isclicked then
		love.graphics.draw(self.unclicked,self.posx,self.posy)
	else
		love.graphics.draw(self.clicked,self.posx,self.posy)
	end
end
