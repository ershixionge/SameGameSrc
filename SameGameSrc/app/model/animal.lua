function createAnimal(layer)
	local n = 7
	local daiji = {}
	local source="xiaoxiaole_output/xiaoxiaole"
	local png=source..".png"
	local plist=source..".plist"
	local xml=source..".xml"
	print(png,plist,xml)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(png,plist,xml);
	local animal = {}
	local positionExchange = {}
	positionExchange[1] = {0,0,49}
	positionExchange[2] = {0,0}
	local function onTouchBegan(touch,event)
		local i = 49
		for j = 0,n*n-1 do
			local locationInNode = animal[j].type:convertToNodeSpace(touch:getLocation())
			if locationInNode.x<32.5 and locationInNode.y<32.5 and locationInNode.x>-32.5 and locationInNode.y>-32.5 then
				i = j
			end
		end
		positionExchange[1][1] = animal[i].positionX
		positionExchange[1][2] = animal[i].positionY
		positionExchange[1][3] = i
		return true
	end
	local function onTouchEnded(touch,event)
		local i = 49
		for j = 0,n*n-1 do
			local locationInNode = animal[j].type:convertToNodeSpace(touch:getLocation())
			if locationInNode.x<32.5 and locationInNode.y<32.5 and locationInNode.x>-32.5 and locationInNode.y>-32.5 then
				i = j
			end
		end
		positionExchange[2][1] = animal[i].positionX
		positionExchange[2][2] = animal[i].positionY
		-- positionExchange[2][3] = i
		animal[positionExchange[1][3]].positionX = positionExchange[2][1]
		animal[positionExchange[1][3]].positionY = positionExchange[2][2]
		animal[i].positionX = positionExchange[1][1]
		-- print(animal[i].positionX)
		animal[i].positionY = positionExchange[1][2]
		animal[i].type:setPosition(cc.p(65 + animal[i].positionX*65,65+animal[i].positionY*65))
		animal[positionExchange[1][3]].type:setPosition(cc.p(65 + animal[positionExchange[1][3]].positionX*65,65+animal[positionExchange[1][3]].positionY*65))
		animal[i].a = 1
		animal[positionExchange[1][3]].a = 1
	end
	-- local function onTouched(touch,event)
	-- 	--local node = event:getCurrentTarget()
	-- 	local i = 49
	-- 	for j = 0,n*n-1 do
	-- 		local locationInNode = animal[j].type:convertToNodeSpace(touch:getLocation())
	-- 		-- print("locationInNode.x = "..locationInNode.x)
	-- 		-- print("locationInNode.y = "..locationInNode.y)
	-- 		if locationInNode.x<32.5 and locationInNode.y<32.5 and locationInNode.x>-32.5 and locationInNode.y>-32.5 then
	-- 			i = j
	-- 		end
	-- 	end
	-- 	print(positionExchange[1][1],positionExchange[1][2],positionExchange[1][3])
	-- 	-- local i = node:getTag()
	-- 	print("i = "..i)
	-- 	if positionExchange[1][1] == 0 and positionExchange[1][2] == 0 and positionExchange[1][3] == 0 then
	-- 		print"进入1"
	-- 		positionExchange[1][1] = animal[i].positionX
	-- 		positionExchange[1][2] = animal[i].positionY
	-- 		positionExchange[1][3] = i
	-- 		print(positionExchange[1][1],positionExchange[1][2],positionExchange[1][3])
	-- 	else 
	-- 		positionExchange[2] = {animal[i].positionX,animal[i].positionY}
	-- 		animal[positionExchange[1][3]].positionX = positionExchange[2][1]
	-- 		animal[positionExchange[1][3]].positionY = positionExchange[2][2]
	-- 		animal[i].positionX = positionExchange[1][1]
	-- 		print(animal[i].positionX)
	-- 		animal[i].positionY = positionExchange[1][2]
	-- 		animal[i].type:setPosition(cc.p(65 + animal[i].positionX*65,65+animal[i].positionY*65))
	-- 		animal[positionExchange[1][3]].type:setPosition(cc.p(65 + animal[positionExchange[1][3]].positionX*65,65+animal[positionExchange[1][3]].positionY*65))
	-- 		animal[i].a = 1
	-- 		animal[positionExchange[1][3]].a = 1
	-- 		positionExchange[1][1] = 0
	-- 		positionExchange[1][2] = 0
	-- 		positionExchange[1][3] = 0
	-- 		positionExchange[2][1] = 0
	-- 		positionExchange[2][2] = 0
	-- 		print("进入2")
	-- 		print(positionExchange[1][1],positionExchange[1][2],positionExchange[1][3])
	-- 		-- layer:openSchedule()
	-- 	end
	-- end
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,layer)
	for i = 0,n*n-1 do
		-- local function onTouched()
		-- 	print(positionExchange[1][1],positionExchange[1][2],positionExchange[1][3])
		-- 	if positionExchange[1][1] == 0 and positionExchange[1][2] == 0 and positionExchange[1][3] == 0 then
		-- 		positionExchange[1] = {animal[i].positionX,animal[i].positionY,i}
		-- 		print(positionExchange[1])
		-- 	else 
		-- 		positionExchange[2] = {animal[i].positionX,animal[i].positionY}
		-- 		animal[positionExchange[1][3]].positionX = positionExchange[2].positionX
		-- 		animal[positionExchange[1][3]].positionY = positionExchange[2].positionY
		-- 		animal[i].positionX = positionExchange[1][1]
		-- 		print(animal[i].positionX)
		-- 		animal[i].positionY = positionExchange[1][2]
		-- 		animal[i].type:setPosition(cc.p(65 + animal[i].positionX*65,65+animal[i].positionY*65))
		-- 		animal[positionExchange[1][3]].type:setPosition(cc.p(65 + animal[positionExchange[1].num].positionX*65,65+animal[ipositionExchange[1].num].positionY*65))
		-- 		positionExchange[1] = {0,0,0}
		-- 		positionExchange[2] = {0,0}
		-- 		animal[i].a = 1
		-- 		animal[positionExchange[1][3]].a = 1
		-- 	end
		-- end
		animal[i] = {type = 0, a = 1, b = 2, c = math.random(1,6), positionX = math.fmod(i,n), positionY = math.modf(i/n)}
		if animal[i].c == 1 then
			animal[i].type = ccs.Armature:create("ya_teshudaiji")
		elseif animal[i].c == 2 then
			animal[i].type = ccs.Armature:create("tuzi_teshudaiji")
		elseif animal[i].c == 3 then
			animal[i].type = ccs.Armature:create("pig_teshudaiji")
		elseif animal[i].c == 4 then
			animal[i].type = ccs.Armature:create("niu_teshudaiji")
		elseif animal[i].c == 5 then
			animal[i].type = ccs.Armature:create("mao_teshudaiji")
		else
			animal[i].type = ccs.Armature:create("dog_teshudaiji")
			animal[i].type:setVisible(false)
		end
		layer:addChild(animal[i].type,10)
		animal[i].type:setPosition(cc.p(65 + animal[i].positionX*65,65+animal[i].positionY*65))
		-- local listener = {}
		-- listener[i] = firstListener:clone()
		animal[i].type:setTag(i)
		-- animal[i].listener:registerScriptHandler(onTouched,cc.Handler.EVENT_TOUCH_BEGAN)
		-- animal[i].listener:setSwallowTouches(true)
		-- local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
		-- eventDispatcher:addEventListenerWithSceneGraphPriority(listener[i],layer)
	end
	return animal
end
