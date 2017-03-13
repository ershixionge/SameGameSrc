local GameController = class("GameController")
function GameController:ctor()
	-- require("app.model.GameModel")
	self._width = GameModel:getWidth()
	self._height = GameModel:getHeight()
	self._posExchange = {}
	self._posExchange[1] = {0,0,self._width*self._height}
	self._posExchange[2] = {0,0}
	self._animalNode = GameModel:getAnimalNode()
end
function GameController:onTouchBegan(touch,event)
	local i = 0
	local locationInNode = self._animalNode[i]:getContent():convertToNodeSpace(touch:getLocation())
	while not(locationInNode.x<32.5 and locationInNode.y<32.5 and locationInNode.x>-32.5 and locationInNode.y>-32.5) do
		i = i+1
		locationInNode = self._animalNode[i]:getContent():convertToNodeSpace(touch:getLocation())
	end
	self._posExchange[1][1] = self._animalNode[i]:getPositionX()
	self._posExchange[1][2] = self._animalNode[i]:getPositionY()
	self._posExchange[1][3] = i
	return true
end
function GameController:onTouchEnded(touch,event)
	local i = 0
	local locationInNode = self._animalNode[i]:getContent():convertToNodeSpace(touch:getLocation())
	while not(locationInNode.x<32.5 and locationInNode.y<32.5 and locationInNode.x>-32.5 and locationInNode.y>-32.5) do
		i = i+1
		locationInNode = self._animalNode[i]:getContent():convertToNodeSpace(touch:getLocation())
	end 
	self._posExchange[2][1] = self._animalNode[i]:getPositionX()
	self._posExchange[2][2] = self._animalNode[i]:getPositionY()
	self._animalNode[self._posExchange[1][3]]:setPositionX(self._posExchange[2][1])
	self._animalNode[self._posExchange[1][3]]:setPositionY(self._posExchange[2][2])
	self._animalNode[i]:setPositionX(self._posExchange[1][1])
	self._animalNode[i]:setPositionY(self._posExchange[1][2])
	self._animalNode[i]:getContent():setPosition(cc.p((self._animalNode[i]:getPositionX()+1)*65,(self._animalNode[i]:getPositionY()+1)*65))
	self._animalNode[self._posExchange[1][3]]:getContent():setPosition(cc.p((self._animalNode[self._posExchange[1][3]]:getPositionX()+1)*65,(self._animalNode[self._posExchange[1][3]]:getPositionY()+1)*65))
	self._animalNode[i]:setJustFill(1)
	self._animalNode[self._posExchange[1][3]]:setJustFill(1)
end
return GameController