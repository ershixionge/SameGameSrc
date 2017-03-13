local GridInfo = class("GridInfo")
function GridInfo:ctor(pos)
	self._pos=pos
end
function GridInfo:createNode(parent)
	self._content = cc.Sprite:create("square/Square_TEMP.png")
	self._content:setPosition(cc.p((self._pos.x+1)*65,(self._pos.y+1)*65))
	parent:addChild(self._content)
	print "testGrid"
end
function GridInfo:getPosition()
	return self._pos
end
return GridInfo
