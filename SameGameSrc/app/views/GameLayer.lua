local GameLayer=class("GameLayer",function ()
	return cc.Layer:create()
end)
function GameLayer:ctor()
	self:enableNodeEvents()
	self._eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	self._GameController = GameModel:getGameController()
end
function GameLayer:onEnter()
	-- print""
	print"testEnter"
	self._listener = cc.EventListenerTouchOneByOne:create()
	-- local GameController = require("app.controller.GameController").new()
	local function onTouchBegan(touch,event)
		self._GameController:onTouchBegan(touch,event)
		return true
	end
	local function onTouchEnded(touch,event)
		self._GameController:onTouchEnded(touch,event)
	end
	self._listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	self._listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	self._eventDispatcher:addEventListenerWithSceneGraphPriority(self._listener,self)
end
function GameLayer:onExit()
	self._eventDispatcher:removeEventListener(self._listener)
end
function GameLayer:openSchedule()
	local function myUpdate()
		GameModel:updateFrame()
	end
	self:scheduleUpdate(myUpdate)
end

return GameLayer