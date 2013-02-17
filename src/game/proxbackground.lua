--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

ProxBackground = {}
ProxBackground.__index =  ProxBackground
function ProxBackground:new(gameplay)
    local self = {}
    self.bgsize = 2000
    setmetatable(self,ProxBackground)
    self.gp = gameplay
    self.backs ={ImgDirectory.."firstfg.png", ImgDirectory.."firstfg.png"}
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
    self.nbBlocs=0
    return self
end

function ProxBackground:update(dt)
	self.myScrolled=self.gp.scrolledDistance
	if self.myScrolled+1024 -self.nbBlocs*self.bgsize>1024 and not self.done then
		self.drawNext=true
		self.nx=self.cx+self.bgsize
		self.nextBg=love.graphics.newImage(self.backs[(self.currentbgnum+1)% (self.nbBG+1)])
	 	self.done =true
	 	print("new detected")
	end
	if self.nx-self.myScrolled<0 and self.done  then
		self.drawNext=false
		self.cx=self.nx
		self.currentbgnum=((self.currentbgnum+1)% self.nbBG)
		self.currentBg=self.nextBg
		self.done=false
		self.nbBlocs= self.nbBlocs+1
		print("new replaced")

	end
end

function ProxBackground:draw()
		--love.graphics.draw(self.currentBg,self.cx-self.myScrolled,0)
		if self.drawNext then
		--love.graphics.draw(self.nextBg,self.nx-self.myScrolled,0)
		end
end
