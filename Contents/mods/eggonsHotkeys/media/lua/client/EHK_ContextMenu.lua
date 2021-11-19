local function addHotActionsOptions(context)
    local HotActionsOption = context:addOption("HotActions")
    local HotActionsSubMenu = ISContextMenu:getNew(context)
    context:addSubMenu(HotActionsOption, HotActionsSubMenu)
    for key, keyConfig in pairs(EHK.keyConfigs) do
        if keyConfig.isHotAction then
            HotActionsSubMenu:addOption(keyConfig.displayName, tostring(getCore():getKey(key)), keyConfig.action)
        end
    end
end

local function addFlexKeyOptions(context)
    local FlexKeyOption = context:addOption("FlexKey")
    local FlexKeySubMenu = ISContextMenu:getNew(context)
    context:addSubMenu(FlexKeyOption, FlexKeySubMenu)
    for key, keyConfig in pairs(EHK.keyConfigs) do
        if keyConfig.isFlexKey then
            FlexKeySubMenu:addOption(keyConfig.displayName, key, EHK.registerFlexKey)
        end
    end
end

local function addEHKOptions(player, context, worldObjects)
    if EHK.Options.displayHotActions then
        addHotActionsOptions(context)
    end
    if EHK.Options.displayFlexKey then
        addFlexKeyOptions(context)
    end
end

Events.OnFillWorldObjectContextMenu.Add(addEHKOptions)
