local ui_utils = {}

local function Destroy(component)
    if is_uicomponent(component) then
        local parent = component:Parent()
                
        if is_uicomponent(parent) then
            parent:Divorce(component:Address())
        end
    end
end

local function GetTransform(component)
    if is_uicomponent(component) then
        local x, y = component:Position()
        local w, h = component:Dimensions()

        return x, y, w, h
    end
    
    return 0, 0, 0, 0
end

local function SetRelativePosition(component, relativeComponent, x, y, fromBottomRight)
    if is_uicomponent(component) and is_uicomponent(relativeComponent) then
        local x0, y0, w0, h0 = GetTransform(relativeComponent)
        
        if fromBottomRight then
            component:MoveTo(x0 + w0 + x, y0 + h0 + y)
        elseif is_uicomponent(relativeComponent) then
            component:MoveTo(x0 + x, y0 + y)
        end
    end
end

local function SetSize(component, width, height, forceResize)
    if is_uicomponent(component) then
        if forceResize then
            component:SetCanResizeHeight(true);
            component:SetCanResizeWidth(true);
            component:Resize(width, height);
            component:SetCanResizeHeight(false);
            component:SetCanResizeWidth(false);
        else
            component:Resize(width, height);
        end
    end
end

------------------------------------------------------------

ui_utils.Destroy = Destroy
ui_utils.GetTransform = GetTransform
ui_utils.SetRelativePosition = SetRelativePosition
ui_utils.SetSize = SetSize

return ui_utils