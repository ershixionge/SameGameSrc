
local MainScene = class("MainScene", function() return cc.Scene:create() end)

function MainScene:ctor()
    local layer=require("app.views.TestLayer").new()
    self:addChild(layer)
	local visibleSize=cc.Director:getInstance():getVisibleSize() 
end

return MainScene
