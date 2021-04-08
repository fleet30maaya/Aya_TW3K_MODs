UI_Mod_UIPanel = Object:extend()

local UI_MOD_PANEL_NAME = "ui_mod_panel_"

local bt_close_size_x   = 36
local bt_close_size_y   = 36
local bt_execute_size_x = 200
local bt_execute_size_y = 50
local bt_top_size_x     = 25

local panel_size_x      = 800
local panel_size_y      = 800

local pn_position_x     = 150
local pn_position_y     = 130
local pn_prop_priority  = 100

-------------------------------------- Panel --------------------------------------

function UI_Mod_UIPanel:new()
    local ui_root = core:get_ui_root()

    ui_root:CreateComponent(
        UI_MOD_PANEL_NAME,
        "ui/templates/panel_frame"
    )
    
    self.ui_panel = find_uicomponent(ui_root, UI_MOD_PANEL_NAME)
    self.ui_panel:PropagatePriority(ui_root:Priority())

    local x, y, w, h = ui.GetTransform(ui_root)
    ui.SetRelativePosition(self.ui_panel, ui_root, (w-panel_size_x)/2, (h-panel_size_y)/2, false)
    ui.SetSize(self.ui_panel, panel_size_x, panel_size_y, true)

    self:create_bt_close()
    ui.SetRelativePosition(self.bt_close, self.ui_panel, panel_size_x - bt_close_size_x - 5, 5, false)

    self:create_bt_execute()
    ui.SetRelativePosition(self.bt_execute, self.ui_panel, panel_size_x/2 - bt_execute_size_x/2, panel_size_y/2 - bt_execute_size_y/2, false)

    core:add_listener(
        "ui_mod_key_listener",
        "OnKeyPressed",
        function(context) return context:is_key_up_event() end,
        function(context)
            --
        end,
        true
    )

    self:refreshUI()
end

function UI_Mod_UIPanel:UIComponent()
    return self.ui_panel
end

function UI_Mod_UIPanel:create_bt_execute()
    self.ui_panel:CreateComponent(
        UI_MOD_PANEL_NAME.."_bt_execute",
        "ui/templates/square_large_text_button"
    )
    self.bt_execute = find_uicomponent(self.ui_panel, UI_MOD_PANEL_NAME.."_bt_execute")
    self.bt_execute:PropagatePriority(self.ui_panel:Priority())
    ui.SetSize(self.bt_execute, bt_execute_size_x, bt_execute_size_y, true)

    find_uicomponent(self.bt_execute, "button_txt"):SetStateText("显示消息")
    self.bt_execute:SetState("down")
    find_uicomponent(self.bt_execute, "button_txt"):SetStateText("显示消息")
    self.bt_execute:SetState("active")
    self.bt_execute:SetTooltipText("测试", true)
    self.bt_execute:SetImagePath("ui/skins/default/duel_btn_gold_frame.png")
 
    core:add_listener(
        UI_MOD_PANEL_NAME.."_bt_execute_click_up",
        "ComponentLClickUp",
        function(context)
            return self.bt_execute == UIComponent(context.component)
        end,
        function(context)
            effect.advice("一个测试信息。")
        end,
        true
    )
end

function UI_Mod_UIPanel:refreshUI()
    local local_faction = cm:get_local_faction()
    out("[UI Mod] Player is faction: " .. local_faction)

    -- local fac = cm:query_local_faction(true)
    -- -- 3k 允许一个派系有多种 pr，因此会获取到一个 pr 列表，在其中找自己想要的资源
    -- local pr_obj = fac:pooled_resources():resource("3k_main_pooled_resource_unity")
    -- if pr_obj then
    --     local val = pr_obj:value()
    --     out("[UI Mod] PR: " .. val)
    -- else
    --     out("[UI Mod] Get PR failed")
    -- end   
end

function UI_Mod_UIPanel:destory_bt_execute()
    core:remove_listener(UI_MOD_PANEL_NAME.."_bt_execute_click_up")
    ui.Destroy(self.bt_execute)
    self.bt_execute = nil
end

function UI_Mod_UIPanel:create_bt_close()
    self.ui_panel:CreateComponent(
        UI_MOD_PANEL_NAME.."_bt_close",
        "ui/templates/3k_btn_close_32"
    )
    self.bt_close = find_uicomponent(self.ui_panel, UI_MOD_PANEL_NAME.."_bt_close")
    self.bt_close:PropagatePriority(self.ui_panel:Priority())
    self.bt_close:SetTooltipText("关闭", true)
    ui.SetSize(self.bt_close, bt_close_size_x, bt_close_size_y, true)
    
    core:add_listener(
        UI_MOD_PANEL_NAME.."_bt_close_click_up",
        "ComponentLClickUp",
        function(context)
            return self.bt_close == UIComponent(context.component)
        end,
        function(context)
            self:toggle_visible()
        end,
        true
    )
end

function UI_Mod_UIPanel:destory_bt_close()
    core:remove_listener(UI_MOD_PANEL_NAME.."_bt_close_click_up")
    ui.Destroy(self.bt_close)
    self.bt_close = nil
end


function UI_Mod_UIPanel:get_visible()
    return self.ui_panel:Visible()
end

function UI_Mod_UIPanel:show()
    if is_uicomponent(self.ui_panel)then
        self:refreshUI()
        self.ui_panel:SetVisible(true)
    end
end

function UI_Mod_UIPanel:hide()
    if is_uicomponent(self.ui_panel)then
        self.ui_panel:SetVisible(false)
    end
end

function UI_Mod_UIPanel:toggle_visible()
    if is_uicomponent(self.ui_panel)then
        if self.ui_panel:Visible()then
            self:hide()
        else
            self:show()
        end
    end
end

function UI_Mod_UIPanel:destroy()
    self:hide()

    if is_uicomponent(self.ui_panel)then
        self:destory_bt_execute()
        self:destory_bt_close()

        ui.Destroy(self.ui_panel)
        
        self.ui_panel = nil
    end
end
