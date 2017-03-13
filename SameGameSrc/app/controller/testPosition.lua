function testPosition(animal)
	local n = 7
	for i = 0,n*n-1 do 
		if animal[i].b == 0 then
			local currentPositionX,currentPositionY = animal[i].type:getPosition()
			if currentPositionY <= 65.01+animal[i].positionY*65 then 
				animal[i].a = 1
				animal[i].b = 2 --b没有意义
			end
		end
	end
end
