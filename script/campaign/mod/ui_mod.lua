------------------------------------------------------------
-- 准备环境
local env_0 = getfenv(0)
setfenv(0, getfenv(1))

------------------------------------------------------------

Object = require "lib.classic"  -- class
ui     = require "lib.UI_Mod_lib_ui"

-- UI Mod class
require("components.UI_Mod")

-- UI Mod instance
local _ui_mod = UI_Mod()

------------------------------------------------------------

setfenv(0, env_0)

-- 准备环境结束
------------------------------------------------------------


-- 入口
-- 基本上，什么也没干
function ui_mod(context)
end
