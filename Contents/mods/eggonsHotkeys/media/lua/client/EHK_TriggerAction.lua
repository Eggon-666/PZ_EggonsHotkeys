EHK = EHK or {}

function EHK.generateKeyActionsTable()
    local ActionForKey = {}
    for keyVar, cfg in pairs(EHK.keyConfigs) do
        ActionForKey[tostring(getCore():getKey(keyVar))] = cfg.action
    end
    if EHK_Plugin then
        for keyVar, cfg in pairs(EHK_Plugin.keyConfigs) do
            ActionForKey[tostring(getCore():getKey(keyVar))] = cfg.action
        end
    end
    return ActionForKey
end

EHK.triggerAction = function(keyPressed)
    local player = getPlayer()
    if not player then
        -- prevents errors when in main menu
        return
    end
    local ActionForKey = EHK.generateKeyActionsTable()
    local keyPressedString = tostring(keyPressed)
    local action = ActionForKey[keyPressedString]
    if action then
        action(keyPressedString)
    end
end

Events.OnCustomUIKey.Add(EHK.triggerAction)
