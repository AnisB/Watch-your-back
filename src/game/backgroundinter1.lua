--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

BackgroundInter1 = {}
BackgroundInter1.__index =  BackgroundInter1
function BackgroundInter1:new(gameplay)
    local self = {}
    self.bgsize = 2000
    setmetatable(self,BackgroundInter1)
    self.gp = gameplay
    self.backs ={ImgDirectory.."boules.png", ImgDirectory.."boules.png"}
    self.nbBG=2
    self.back1 = love.graphics.newImage(self.backs[1])
    self.back2 = love.graphics.newImage(self.backs[2])
    self.currentbgnum=1
    self.currentBg=self.back1
    self.nextBg=self.back2
    self.isclicked=false
    self.cx =0
    self.nx=self.bgsize
    self.drawNext=false
    self.myScrolled =0
        self.nbBlocs =0
    self.done =false
    return self
end


function BackgroundInter1:reset()
    self.currentbgnum=1
    self.currentBg=self.back1
    self.nextBg=self.back2
    self.isclicked=false
    self.cx =0
    self.nx=self.bgsize
    self.drawNext=false
    self.myScrolled =0
        self.nbBlocs =0
    self.done =false
end
function BackgroundInter1:update(dt)
	self.myScrolled=self.gp.scrolledDistance/3
	
	if (self.myScrolled+1024 -self.nbBlocs*self.bgsize)>self.bgsize and not self.done then		
		self.drawNext=true
		self.nx=self.cx+self.bgsize
		self.nextBg=love.graphics.newImage(self.backs[(self.currentbgnum+1)% (self.nbBG+1)])
	 	self.done=true
	end
	if self.nx-self.myScrolled<0 and self.done  then
		self.drawNext=false
		self.cx=self.nx
		self.currentbgnum=((self.currentbgnum+1)% self.nbBG)
		self.currentBg=self.nextBg
		self.done=false
		self.nbBlocs=self.nbBlocs+1
	end
end

function BackgroundInter1:draw()
		love.graphics.draw(self.currentBg,self.cx-self.myScrolled,0)

		if self.drawNext then
		love.graphics.draw(self.nextBg,self.nx-self.myScrolled,0)
		end
end
