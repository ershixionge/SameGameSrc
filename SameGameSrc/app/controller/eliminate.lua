function isEliminate(animal)
	local n = 7
	local j = 1
	local miss = {}
	for i = 0,n*n-1 do
		if animal[i].a == 1 then
			local left = findLeft(animal,i)
			--print(left)
			local right = findRight(animal,i)
			--print(right)
			local down = findDown(animal,i)
			--print(down)
			local up = findUp(animal,i)
			--print(up)
			local c = 1
			if left ~= 49 and right ~= 49 and animal[left].b ~= 0 and animal[right].b ~= 0 then
				if animal[i].c == animal[left].c and animal[i].c == animal[right].c then
					miss[j] = left
					j = j+1
					miss[j] = i
					j = j+1
					miss[j] = right
					j = j+1
					animal[left].type:setVisible(false)
					animal[i].type:setVisible(false)
					animal[right].type:setVisible(false)
					-- animal[left].a = 0
					-- animal[i].a = 0
					-- animal[right].a = 0
					-- animal[left].b = 0
					-- animal[i].b = 0
					-- animal[right].b = 0
					c = 0
				end
			end
			if down ~= 49 and up ~= 49 and animal[down].b ~= 0 and animal[up].b ~= 0 then
				if animal[i].c == animal[down].c and animal[i].c ==animal[up].c then
					miss[j] = down
					j = j+1
					miss[j] = i
					j = j+1
					miss[j] = up
					j = j+1
					animal[down].type:setVisible(false)
					animal[i].type:setVisible(false)
					animal[up].type:setVisible(false)
					-- animal[down].a = 0
					-- animal[i].a = 0
					-- animal[up].a = 0
					-- animal[down].b = 0
					-- animal[i].b = 0
					-- animal[up].b = 0
					c = 0
				end
			end
			if c == 1 then
				local delay = cc.DelayTime:create(1/120)
				-- 延迟0.1秒
				-- animal[i].a = 0
				-- animal[i].b = 1
				print("消除i = "..i)
				print("animal[i].b = "..animal[i].b)
			end
		end
	end
	for m = 1,j-1 do
		animal[miss[m]].a = 0
		animal[miss[m]].b = 0
	end
	return miss,j
end
