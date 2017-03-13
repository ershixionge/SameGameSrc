local GameModel=class("GameModel")
function GameModel:ctor()
	self._animalNode={}
	self._gridNode={}
	self._miss = {}
	self._j = 0
	self:readGameConfig()
end
function GameModel:init()
	self._GameController = require("app.controller.GameController").new()
	self:createView()
	self:createAllAnimals()
	self:createAllGrids()
	self:isEliminate()
	self:emptyFill()
	self._GameLayer:openSchedule()
end
function GameModel:createView()
	local scene=require("app.views.GameScene").new()
	if cc.Director:getInstance():getRunningScene() then
    	cc.Director:getInstance():replaceScene(scene)
    else 
    	cc.Director:getInstance():runWithScene(scene)
    end
	self._GameLayer=scene:getGameLayer()
end
function GameModel:readGameConfig()
	self._width=7
	self._height=8
	for i=0,self._width*self._height-1 do
		self._animalNode[i]=require("app.views.AnimalInfo").new(self:createAnimalType())
	end
end
function GameModel:createAllAnimals()
	for i=0,self._width*self._height-1 do
		local pos = cc.p(math.fmod(i,self._width),math.modf(i/self._width))
		self._animalNode[i]:createNode(self._GameLayer,pos)
	end
end
function GameModel:createAllGrids()
	for i=0,self._width*self._height-1 do 
		local pos = cc.p(math.fmod(i,self._width),math.modf(i/self._width))
		self._gridNode[i] = require("app.views.GridInfo").new(pos)
		self._gridNode[i]:createNode(self._GameLayer)
	end
end
function GameModel:createAnimalType()
	return math.random(1,6)
end
function GameModel:findLeft(i)
	local positionX = self._animalNode[i]:getPositionX()
	local positionY = self._animalNode[i]:getPositionY()
	local left = 0
	while positionX ~= self._animalNode[left]:getPositionX()+1 or positionY ~= self._animalNode[left]:getPositionY() do
		left = left+1
		if left>self._width*self._height-1 then
			break
		end
	end
	return left
end
function GameModel:findRight(i)
	local positionX = self._animalNode[i]:getPositionX()
	local positionY = self._animalNode[i]:getPositionY()
	local right = 0
	while positionX ~= self._animalNode[right]:getPositionX()-1 or positionY ~= self._animalNode[right]:getPositionY() do
		right = right+1
		if right>self._width*self._height-1 then
			break
		end
	end
	return right
end
function GameModel:findDown(i)
	local positionX = self._animalNode[i]:getPositionX()
	local positionY = self._animalNode[i]:getPositionY()
	local down = 0
	while positionY ~= self._animalNode[down]:getPositionY()+1 or positionX ~= self._animalNode[down]:getPositionX() do
		down = down+1
		if down>self._width*self._height-1 then
			break
		end
	end
	return down
end
function GameModel:findUp(i)
	local positionX = self._animalNode[i]:getPositionX()
	local positionY = self._animalNode[i]:getPositionY()
	local up = 0
	while positionY ~= self._animalNode[up]:getPositionY()-1 or positionX ~= self._animalNode[up]:getPositionX() do
		up = up+1
		if up>self._width*self._height-1 then
			break
		end
	end
	return up
end
function GameModel:getWidth()
	return self._width
end
function GameModel:getHeight()
	return self._height
end
function GameModel:getAnimalNode()
	return self._animalNode
end
function GameModel:isEliminate()
	local j = 1
	local left,right,up,down
	for i = 0,self._width*self._height-1 do
		if self._animalNode[i]:getJustFill() == 1 then
			left = self:findLeft(i)
			right = self:findRight(i)
			down = self:findDown(i)
			up = self:findUp(i)
			if left ~= self._width*self._height and right ~= self._width*self._height and self._animalNode[left]:getOverFill() ~= 0 and self._animalNode[right]:getOverFill() ~= 0 then
				if self._animalNode[left]:getType() == self._animalNode[i]:getType() and self._animalNode[right]:getType() == self._animalNode[i]:getType() then
					self._miss[j] = left
					j = j+1
					self._miss[j] = i
					j = j+1
					self._miss[j] = right
					j = j+1
					self._animalNode[left]:getContent():setVisible(false)
					self._animalNode[i]:getContent():setVisible(false)
					self._animalNode[right]:getContent():setVisible(false)
				end
			end
			if down ~= self._width*self._height and up ~= self._width*self._height and self._animalNode[down]:getOverFill() ~= 0 and self._animalNode[up]:getOverFill() ~= 0 then
				if self._animalNode[down]:getType() == self._animalNode[i]:getType() and self._animalNode[up]:getType() == self._animalNode[i]:getType() then
					self._miss[j] = down
					j = j+1
					self._miss[j] = i
					j = j+1
					self._miss[j] = up
					j = j+1
					self._animalNode[down]:getContent():setVisible(false)
					self._animalNode[i]:getContent():setVisible(false)
					self._animalNode[up]:getContent():setVisible(false)
				end
			end
		end
	end
	for m = 1,j-1 do
		self._animalNode[self._miss[m]]:setJustFill(0)
		self._animalNode[self._miss[m]]:setOverFill(0)
	end
	self._j = j
	print("进入消除")
end

function GameModel:emptyFill()
	if self._j ~= 0 then
		for i = 1,self._j-1 do
			local dog
			local straight = 1
			for m = 0,self._width*self._height-1 do
				if self._animalNode[m]:getPositionX() == self._animalNode[self._miss[i]]:getPositionX() and self._animalNode[m]:getPositionY()>self._animalNode[self._miss[i]]:getPositionY() and self._animalNode[m]:getType() == 6 then
					dog = m
					straight = 0
				end
			end
			if straight == 1 then
				for num = 0,self._width*self._height-1 do
					if self._animalNode[num]:getPositionX() == self._animalNode[self._miss[i]]:getPositionX() and self._animalNode[num]:getPositionY()>self._animalNode[self._miss[i]]:getPositionY() then
						self._animalNode[num]:setPositionY(self._animalNode[num]:getPositionY()-1)
						self._animalNode[num]:setJustFill(0)
						self._animalNode[num]:setOverFill(0)
						self._animalNode[num]:getContent():runAction(cc.MoveBy:create(3,cc.p(0, -65)))
						-- print("Y = "..self._animalNode[num]:getPositionY())
					end
				end
			else 
				for num = 0,self._width*self._height-1 do
					if self._animalNode[num]:getPositionX() == self._animalNode[self._miss[i]]:getPositionX()+1 and self._animalNode[num]:getPositionY()>self._animalNode[dog]:getPositionY() then
						self._animalNode[num]:setPositionY(self._animalNode[num]:getPositionY()-1)
						self._animalNode[num]:setJustFill(0)
						self._animalNode[num]:setOverFill(0)
						self._animalNode[num]:getContent():runAction(cc.MoveBy:create(3,cc.p(0, -65)))
						-- print("Y = "..self._animalNode[num]:getPositionY())
					elseif self._animalNode[num]:getPositionX() == self._animalNode[self._miss[i]]:getPositionX() and self._animalNode[num]:getPositionY()<self._animalNode[dog]:getPositionY() and self._animalNode[num]:getPositionY()>self._animalNode[self._miss[i]]:getPositionY() then
						self._animalNode[num]:setPositionY(self._animalNode[num]:getPositionY()-1)
						self._animalNode[num]:setJustFill(0)
						self._animalNode[num]:setOverFill(0)
						self._animalNode[num]:getContent():runAction(cc.MoveBy:create(3,cc.p(0, -65)))
						-- print("Y = "..self._animalNode[num]:getPositionY())
					elseif self._animalNode[num]:getPositionX() == self._animalNode[self._miss[i]]:getPositionX()+1 and self._animalNode[num]:getPositionY()==self._animalNode[dog]:getPositionY() then
						self._animalNode[num]:setPositionY(self._animalNode[num]:getPositionY()-1)
						self._animalNode[num]:setPositionX(self._animalNode[num]:getPositionX()-1) 
						self._animalNode[num]:setJustFill(0)
						self._animalNode[num]:setOverFill(0)
						self._animalNode[num]:getContent():runAction(cc.MoveBy:create(3,cc.p(-65, -65)))
						-- print("Y = "..self._animalNode[num]:getPositionY())
						-- print("移动后："..((animal[num].positionY+1)*65))
						-- end
					end
				end
			end
			self._animalNode[self._miss[i]]:reCreateNode(i,straight,self._GameLayer)
			self._animalNode[self._miss[i]]:getContent():runAction(cc.MoveBy:create(3,cc.p(0, -65*i)))
			self._animalNode[self._miss[i]]:setPositionY(self._animalNode[self._miss[i]]:getPositionY()-i)
		end
	end
	self._j = 0
	self._miss = nil
	self._miss = {}
end
function GameModel:testPosition()
	for i = 0,self._width*self._height-1 do 
		if self._animalNode[i]:getOverFill() == 0 then
			local currentPositionX,currentPositionY = self._animalNode[i]:getContent():getPosition()
			if currentPositionY <= 65.01+self._animalNode[i]:getPositionY()*65 then 
				self._animalNode[i]:setJustFill(1)
				self._animalNode[i]:setOverFill(2)
			end
		end
	end
end
function GameModel:updateFrame()
	self:testPosition()
	self:emptyFill()
	self:isEliminate()
	print(self._j)
	local sign = 0
	for i = 0,self._width*self._height-1 do
		if self._animalNode[i]:getOverFill() ~= 1 then
			sign = 1
		end
	end
	print("sign = "..sign)
	if sign == 0 then
		self._GameLayer:unscheduleUpdate()
	end
end
function GameModel:getGameController()
	return self._GameController
end
return GameModel


