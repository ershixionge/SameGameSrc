
local GameScene = class("GameScene", function() return cc.Scene:create() end)

function GameScene:ctor()
    self._layer=require("app.views.GameLayer").new()
    self:addChild(self._layer)
end
function GameScene:getGameLayer()
	return self._layer
end


return GameScene
