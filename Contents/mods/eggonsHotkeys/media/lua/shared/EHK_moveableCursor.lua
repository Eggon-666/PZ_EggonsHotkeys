EHK = EHK or {}
-- defaults = {
--     pickup = 200,
--     place = 208,
--     rotate = 205,
--     scrap = 211
-- }

EHK.createCursor = function(mode)
    local cursor = ISMoveableCursor:new(getPlayer())
    getCell():setDrag(cursor, cursor.player)
    cursor:setMoveableMode(mode)
end

EHK.triggerAction = function(keyPressed)
    -- print(keyPressed)
    local ActionForKey = {
        [tostring(getCore():getKey("smoke"))] = EHK.smoke,
        [tostring(getCore():getKey("betaBlockers"))] = EHK.takeBetaBlockers,
        [tostring(getCore():getKey("painKillers"))] = EHK.takePainKillers
    }
    -- local SmokingKeyCode = tostring(getCore():getKey("smoke"))
    -- local BetaBlockersKeyCode = tostring(getCore():getKey("betaBlockers"))
    -- local PainKillersKeyCode = tostring(getCore():getKey("painKillers"))
    local action = ActionForKey[tostring(keyPressed)]
    -- if tostring(keyPressed) == SmokingKeyCode then
    --     EHK.smoke()
    if action then
        action()
    else
        local FurnitureKeyCodes = {
            pickup = tostring(getCore():getKey("pickup")),
            place = tostring(getCore():getKey("place")),
            rotate = tostring(getCore():getKey("rotate")),
            scrap = tostring(getCore():getKey("scrap"))
        }
        local identifiedCommand
        for k, v in pairs(FurnitureKeyCodes) do
            -- print(k, "= ", v)
            if tostring(keyPressed) == v then
                identifiedCommand = k
            end
        end
        if identifiedCommand then
            EHK.createCursor(identifiedCommand)
        end
    end
end

Events.OnCustomUIKey.Add(EHK.triggerAction)
