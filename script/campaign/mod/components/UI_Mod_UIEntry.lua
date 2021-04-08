require "components.UI_Mod_UIPanel"

UI_Mod_UIEntry = Object:extend()

local UI_MOD_NAME = "ui_mod_"

------------------------------------------------------------
-- 主界面按钮
------------------------------------------------------------
function UI_Mod_UIEntry:createMenuButton()
    local parent = find_uicomponent(
        core:get_ui_root(),
        "hud_campaign",
        "top_faction_header",
        "campaign_hud_faction_header",
        "button_parent"
    )

    parent:CreateComponent(
        UI_MOD_NAME.."_bt_menu",
        "ui/templates/3k_btn_medium"  -- fast.pack
    )
    
    self.menu_button = find_uicomponent(parent, UI_MOD_NAME.."_bt_menu")
    self.menu_button:SetImagePath("ui/skins/default/item_set_counter_2.png")-- fast.pack
    self.menu_button:SetOpacity(true, 255)
    self.menu_button:SetTooltipText("面板", true)

    core:add_listener(
        UI_MOD_NAME.."_bt_menu_click_up",
        "ComponentLClickUp",
        function(context)
            return UIComponent(context.component)== self.menu_button
        end,
        function(context)
            if self.uimod_panel and self.uimod_panel:UIComponent()then
                self.uimod_panel:toggle_visible()
            else
                self.uimod_panel = UI_Mod_UIPanel()
            end
        end,
        true
    )
end

function UI_Mod_UIEntry:destroyMenuButton()
    if is_uicomponent(self.menu_button) then
        self.menu_button:Destroy()
    end
end

------------------------------------------------------------
-- 回调入口
------------------------------------------------------------
function UI_Mod_UIEntry:on_ui_created(context)
    if not UI_Mod then
        return
    end
    
    if context.string == "Campaign UI" then
        self:createMenuButton()
        -- self:add_ui_event_listeners()
    else
        -- self:uninitialize()
        self:destroyMenuButton()
    end
end

function UI_Mod_UIEntry:on_ui_destroyed(context)
    if context.string == "Campaign UI" then
        -- self:uninitialize()
        self:destroyMenuButton()
    end
end

core:add_ui_created_callback(function(context) UI_Mod_UIEntry:on_ui_created(context) end)
core:add_ui_destroyed_callback(function(context) UI_Mod_UIEntry:on_ui_destroyed(context) end)
