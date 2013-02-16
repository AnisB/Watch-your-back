--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

Background = {}
Background.__index =  Background
function Background:new(gameplay)
    local self = {}
    self.bgsize = 1280
    setmetatable(self,Background)
    self.gp = gameplay
    self.backs ={ImgDirectory.."firstbg.png", ImgDirectory.."secondbg.png"}
    self.nbBG=2
    self.back1 = love.graphics.newImage(self.backs[1])
    self.back2 = love.graphics.newImage(self.backs[2])
    self.currentbgnum=1
    self.currentBg=self.back1
    self.nextBg=self.back2
    self.isclicked=false
    self.cx =0
    self.nx=1281
    self.drawNext=false
    self.myScrolled =0
    return self
end

function Background:update(dt)
	self.myScrolled=self.gp.scrolledDistance/10
	
	if math.floor((self.myScrolled+1024)%1280)>0 and math.floor((self.myScrolled+1024)%1280)< 10 then
		self.drawNext=true
		self.nx=self.cx+1280
		self.nextBg=love.graphics.newImage(self.backs[(self.currentbgnum+1)% (self.nbBG+1)])
	 	
	end
	if math.abs((math.floor(self.nx)-math.floor(self.myScrolled)))<5  then
		self.drawNext=false
		self.cx=self.nx
		self.currentbgnum=((self.currentbgnum+1)% self.nbBG)
		self.currentBg=self.nextBg
	end
end

function Background:draw()
		love.graphics.draw(self.currentBg,self.cx-self.myScrolled,0)
		if self.drawNext then
		love.graphics.draw(self.nextBg,self.nx-self.myScrolled,0)
		end
end
