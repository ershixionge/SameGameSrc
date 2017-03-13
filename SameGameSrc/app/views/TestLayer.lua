local TestLayer=class("TestLayer",function ()
	-- body
	return cc.Layer:create()
end)
function TestLayer:ctor()
	-- local square = cc.Sprite:create("square/Square_TEMP.png")
	-- local square1 = cc.Sprite:create("square/Square_TEMP.png")
	-- local source="xiaoxiaole_output/xiaoxiaole"
	-- local png=source..".png"
	-- local plist=source..".plist"
	-- local xml=source..".xml"
	-- print(png,plist,xml)
	-- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo( png,plist,xml);
	-- local armature=ccs.Armature:create("ya_teshudaiji")
	-- local armature1 = ccs.Armature:create("tuzi_teshudaiji")
	-- self:addChild(armature1,10)
	-- self:addChild(armature,10)
	-- self:addChild(square,0)
	-- self:addChild(square1,0)
	-- local visibleSize=cc.Director:getInstance():getVisibleSize()
	-- square:setPosition(visibleSize.width/2,visibleSize.height/2)
	-- armature:setPosition(visibleSize.width/2,visibleSize.height/2)
	-- square1:setPosition(visibleSize.width/2 - 65,visibleSize.height/2)
	-- armature1:setPosition(visibleSize.width/2 - 65,visibleSize.height/2)
	local square = createSquare(self)
	self._animal = createAnimal(self)
	self._miss = {}
	self._j = 1
	self._miss,self._j = isEliminate(self._animal)
	print("miss1 = "..self._miss[1])
	print("miss2 = "..self._miss[2])
	print("miss3 = "..self._miss[3])
	print(self._j)
	emptyFill(self,self._animal,self._miss,self._j)
	-- local function myUpdate()
	-- 	local n = 7
	-- 	testPosition(animal)
	-- 	emptyFill(self,animal,miss,j)
	-- 	print("j = "..j)
	-- 	miss,j = isEliminate(animal)
	-- 	print("j = "..j)
	-- 	-- print("j = "..j)
	-- 	local sign = 0
	-- 	for i = 0,n*n - 1 do
	-- 		if animal[i].b ~= 1 then
	-- 			sign = 1
	-- 		end
	-- 	end
	-- 	print("sign = "..sign)
	-- 	if sign == 0 then
	-- 		self:unscheduleUpdate()
	-- 	end
	-- end
	-- self:scheduleUpdate(myUpdate)
	self:openSchedule()
	-- print("miss4 = "..miss[4])
end
function TestLayer:openSchedule()
	local function myUpdate()
		local n = 7
		testPosition(self._animal)
		emptyFill(self,self._animal,self._miss,self._j)
		print("j = "..self._j)
		self._miss,self._j = isEliminate(self._animal)
		print("j = "..self._j)
		-- print("j = "..j)
		local sign = 0
		for i = 0,n*n - 1 do
			if self._animal[i].b ~= 1 then
				sign = 1
			end
		end
		print("sign = "..sign)
		if sign == 0 then
			self:unscheduleUpdate()
		end
	end
	self:scheduleUpdate(myUpdate)
end
return TestLayer



