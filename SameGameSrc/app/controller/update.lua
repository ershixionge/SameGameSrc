function update(layer,animal,miss,j)
	local n = 7
	testPosition(animal)
	emptyFill(layer,animal,miss,j)
	isEliminate(animal)
	local sign = 0
	for i = 0,n*n - 1 do
		if animal[i].b ~= 1 then
			sign = 1
		end
	end
	if sign == 0 then
		layer:unScheduleUpdate()
	end
end

