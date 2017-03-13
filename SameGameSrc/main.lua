
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"
require "app.model.square"
require "app.model.animal"
require "app.controller.eliminate"
require "app.controller.find"
require "app.controller.emptyFill"
require "app.controller.update"
require "app.controller.testPosition"
--require("app.AppInit");
local function main()
    GameModel=require("app.model.GameModel").new()
    GameModel:init()
    -- GameModel:createView()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
