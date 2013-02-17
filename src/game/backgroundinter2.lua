--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

BackgroundInter2 = {}
BackgroundInter2.__index =  BackgroundInter2
function BackgroundInter2:new(gameplay)
    local self = {}
    self.bgsize = 4000
    setmetatable(self,BackgroundInter2)
    self.gp = gameplay
    self.backs ={ImgDirectory.."eclair1.png", ImgDirectory.."eclair1.png"}
    self.nbBG=2
    self.back1 = love.graphics.newImage(self.backs[1])
    self.back2 = love.graphics.newImage(self.backs[2])
    self.eclair2 = love.graphics.newImage(ImgDirectory.."eclair2.png")
    self.eclair3 = love.graphics.newImage(ImgDirectory.."eclair3.png")
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

function BackgroundInter2:update(dt)
	self.myScrolled=self.gp.scrolledDistance*5
	
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

function BackgroundInter2:draw()
		love.graphics.draw(self.currentBg,self.cx-self.myScrolled,0)
		love.graphics.draw(self.eclair2,self.cx-self.myScrolled,0)
		love.graphics.draw(self.eclair3,self.cx-self.myScrolled,0)

		if self.drawNext then
		love.graphics.draw(self.nextBg,self.nx-self.myScrolled,0)
		love.graphics.draw(self.eclair2,self.nx-self.myScrolled,0)
		love.graphics.draw(self.eclair3,self.nx-self.myScrolled,0)
		end
end
