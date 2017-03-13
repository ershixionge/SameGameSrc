local AnimalInfo=class("AnimalInfo")
function AnimalInfo:ctor(ttype)
	-- self._pos = pos
	self._type=ttype
	-- self._parent = parent
end
function AnimalInfo:createNode(parent,pos)
	-- print(pos.x)
	local source="xiaoxiaole_output/xiaoxiaole"
	local png=source..".png"
	local plist=source..".plist"
	local xml=source..".xml"
	print(png,plist,xml)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(png,plist,xml)
	local armature
	if self._type == 1 then
		armature = ccs.Armature:create("ya_teshudaiji")
	elseif self._type == 2 then
		armature = ccs.Armature:create("tuzi_teshudaiji")
	elseif self._type == 3 then
		armature = ccs.Armature:create("pig_teshudaiji")
	elseif self._type == 4 then
		armature = ccs.Armature:create("niu_teshudaiji")
	elseif self._type == 5 then
		armature = ccs.Armature:create("mao_teshudaiji")
	else
		armature = ccs.Armature:create("dog_teshudaiji")
		-- animal[i].type:setVisible(false)
	end
	parent:addChild(armature,10)
	armature:setPosition(cc.p((pos.x+1)*65,(pos.y+1)*65))
	self._content=armature
	self._justFill = 1
	-- 1:刚刚完成掉落，0：其他
	self._overFill = 2
	-- 1：掉落完成，0：正在掉落，2：无意义，与刚刚完成掉落向匹配
	self._positionX = pos.x
	self._positionY = pos.y
end
function AnimalInfo:getContent()
	return self._content
end
function AnimalInfo:getJustFill()
	return self._justFill
end
function AnimalInfo:getOverFill()
	return self._overFill
end
function AnimalInfo:setJustFill(num)
	self._justFill = num
end
function AnimalInfo:setOverFill(num)
	self._overFill = num
end
function AnimalInfo:getPositionX()
	return self._positionX
end
function AnimalInfo:getPositionY()
	return self._positionY
end
function AnimalInfo:setPositionX(num)
	self._positionX = num
end
function AnimalInfo:setPositionY(num)
	self._positionY = num
end
function AnimalInfo:getType()
	return self._type
end
function AnimalInfo:reCreateNode(i,straight,parent)
	print("straight = "..straight)
	self._justFill = 0
	self._overFill = 0
	self._positionY = 7+i
	self._positionX = self._positionX + (1-straight)
	self._content:removeFromParent()
	self._content = nil
	self._type = math.random(1,5)
	local source="xiaoxiaole_output/xiaoxiaole"
	local png=source..".png"
	local plist=source..".plist"
	local xml=source..".xml"
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(png,plist,xml)
	local armature
	if self._type == 1 then
		armature = ccs.Armature:create("ya_teshudaiji")
	elseif self._type == 2 then
		armature = ccs.Armature:create("tuzi_teshudaiji")
	elseif self._type == 3 then
		armature = ccs.Armature:create("pig_teshudaiji")
	elseif self._type == 4 then
		armature = ccs.Armature:create("niu_teshudaiji")
	else
		armature = ccs.Armature:create("mao_teshudaiji")
	end
	parent:addChild(armature,10)
	self._content = armature
	self._content:setPosition(cc.p((self._positionX+1)*65,(self._positionY+1)*65))
	self._content:setVisible(true)
	-- self._content:runAction(cc.MoveBy:create(0.3,cc.p(0, -65*i)))
	-- self._positionY = self._positionY - i
end

return AnimalInfo


