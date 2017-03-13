function emptyFill(layer,animal,miss,j)
	local n = 7
	if j ~= 0 then
		for i = 1,j-1 do
			--local ups = {}
			--local m = 1
			local dog = 49
			local straight = 1
			for stone = 0,n*n-1 do
				if animal[stone].positionX == animal[miss[i]].positionX and animal[stone].positionY>animal[miss[i]].positionY and animal[stone].c == 6 then
					dog = stone
					straight = 0
				end
			end
			if straight == 1 then
				for num = 0,n*n-1 do
					if animal[num].positionX == animal[miss[i]].positionX and animal[num].positionY>animal[miss[i]].positionY then
						animal[num].positionY = animal[num].positionY-1
						animal[num].a = 0
						animal[num].b = 0
						animal[num].type:runAction(cc.MoveBy:create(0.3,cc.p(0, -65)))
						print("Y = "..animal[num].positionY)
					end
				end
			else 
				for num = 0,n*n-1 do
					if animal[num].positionX == animal[miss[i]].positionX+1 and animal[num].positionY>animal[dog].positionY then
						animal[num].positionY = animal[num].positionY-1
						animal[num].a = 0
						animal[num].b = 0
						animal[num].type:runAction(cc.MoveBy:create(0.3,cc.p(0, -65)))
						print("Y = "..animal[num].positionY)
					elseif animal[num].positionX == animal[miss[i]].positionX and animal[num].positionY<animal[dog].positionY and animal[num].positionY>animal[miss[i]].positionY then
						animal[num].positionY = animal[num].positionY-1
						animal[num].a = 0
						animal[num].b = 0
						animal[num].type:runAction(cc.MoveBy:create(0.3,cc.p(0, -65)))
						print("Y = "..animal[num].positionY)
					elseif animal[num].positionX == animal[miss[i]].positionX+1 and animal[num].positionY==animal[dog].positionY then
						animal[num].positionY = animal[num].positionY-1
						animal[num].positionX = animal[num].positionX-1
						animal[num].a = 0
						animal[num].b = 0
						animal[num].type:runAction(cc.MoveBy:create(0.3,cc.p(-65, -65)))
						print("Y = "..animal[num].positionY)
						-- print("移动后："..((animal[num].positionY+1)*65))
						-- end
					end
				end
			end
			--animal[i] = {type = 0, a = 0, b = 0, c = math.random(1,6), positionX = a, positionY = math.modf(i/n)}
			animal[miss[i]].c = math.random(1,5)
			animal[miss[i]].a = 0
			animal[miss[i]].b = 0
			animal[miss[i]].positionY = 6+i
			animal[miss[i]].positionX = animal[miss[i]].positionX + (1-straight)
			animal[miss[i]].type:removeFromParent()
			animal[miss[i]].type = nil
			-- local source="xiaoxiaole_output/xiaoxiaole"
			-- local png=source..".png"
			-- local plist=source..".plist"
			-- local xml=source..".xml"
			-- print(png,plist,xml)
			-- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(png,plist,xml)
			if animal[miss[i]].c == 1 then
				animal[miss[i]].type = ccs.Armature:create("ya_teshudaiji")
			elseif animal[miss[i]].c == 2 then
				animal[miss[i]].type = ccs.Armature:create("tuzi_teshudaiji")
			elseif animal[miss[i]].c == 3 then
				animal[miss[i]].type = ccs.Armature:create("pig_teshudaiji")
			elseif animal[miss[i]].c == 4 then 
				animal[miss[i]].type = ccs.Armature:create("niu_teshudaiji")
			elseif animal[miss[i]].c == 5 then
				animal[miss[i]].type = ccs.Armature:create("mao_teshudaiji")
			else
				animal[miss[i]].type = ccs.Armature:create("dog_teshudaiji")
			end
			print("type = "..animal[miss[i]].c)
			layer:addChild(animal[miss[i]].type)
			animal[miss[i]].type:setPosition(cc.p(65 + animal[miss[i]].positionX*65,65+animal[miss[i]].positionY*65))
			animal[miss[i]].type:setVisible(true)
			print(miss[i])
			print "test 创建"
			animal[miss[i]].type:runAction(cc.MoveBy:create(0.3,cc.p(0, -65*i)))
			animal[miss[i]].positionY = animal[miss[i]].positionY - i
		end
	end
	j = 0
end

