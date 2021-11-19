function EHK.registerFlexKey(key)
    local player = getPlayer()
    local MD = player:getModData()
    MD.EHK = MD.EHK or {}
    MD.EHK.savedAction = key
end

function EHK.triggerFlexKey()
    local player = getPlayer()
    local MD = player:getModData()
    MD.EHK = MD.EHK or {}
    if MD.EHK.savedAction then
        -- print("FlexKey: ", MD.EHK.savedAction)
        -- printFuckingNormalObject(EHK.keyConfigs[MD.EHK.savedAction], "CFG")
        EHK.keyConfigs[MD.EHK.savedAction].action(tostring(getCore():getKey(MD.EHK.savedAction)))
    end
end
