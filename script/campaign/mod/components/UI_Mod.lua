require "components.UI_Mod_UIEntry"

-- 整个mod的管理类
-- 但因为这个mod除了ui什么也没有，因此这个类也只是建立了ui对象
UI_Mod = Object:extend()

function UI_Mod:new()
    self.ui_entry = UI_Mod_UIEntry()
end
