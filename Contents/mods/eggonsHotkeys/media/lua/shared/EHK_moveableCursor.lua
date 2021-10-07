EHK = {}
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
    local SmokingKeyCode = tostring(getCore():getKey("smoke"))
    if tostring(keyPressed) == SmokingKeyCode then
        EHK.smoke()
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
