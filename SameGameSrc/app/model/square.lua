
function createSquare(layer)
	local n = 7
	local visibleSize=cc.Director:getInstance():getVisibleSize()
	local square = {}
	for i = 0,n*n-1 do
		square[i] = cc.Sprite:create("square/Square_TEMP.png")
		layer:addChild(square[i],0)
		local a = math.modf(i/n)
		local b = math.fmod(i,n)
		--print(a)
		--print(b)
		square[i]:setPosition(65 + b*65,65+a*65)
	end
	return square
end



