local n = 7
function findLeft(animal,i)
	local left = 0
	while animal[i].positionX ~= animal[left].positionX+1 or animal[i].positionY ~= animal[left].positionY do 
		left = left+1
		if left>n*n-1 then
			break
		end
	end
	return left
end
function findRight(animal,i)
	local right = 0
	while animal[i].positionX ~= animal[right].positionX-1 or animal[i].positionY ~= animal[right].positionY do 
		right = right+1
		if right>n*n-1 then
			break
		end
	end
	return right
end
function findDown(animal,i)
	local down = 0
	while animal[i].positionY ~= animal[down].positionY+1 or animal[i].positionX ~= animal[down].positionX do 
		down = down+1
		if down>n*n-1 then
			break
		end
	end
	return down
end
function findUp(animal,i)
	local up = 0
	while animal[i].positionY ~= animal[up].positionY-1 or animal[i].positionX ~= animal[up].positionX do 
		up = up+1
		if up>n*n-1 then
			break
		end
	end
	return up
end