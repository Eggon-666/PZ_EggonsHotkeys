EHK = EHK or {}

EHK.createFurnitureCursor = function(keyPressedString)
    local FurnitureKeyCodes = {
        [tostring(getCore():getKey("pickup"))] = "pickup",
        [tostring(getCore():getKey("place"))] = "place",
        [tostring(getCore():getKey("rotate"))] = "rotate",
        [tostring(getCore():getKey("scrap"))] = "scrap"
    }

    local mode = FurnitureKeyCodes[keyPressedString]

    if mode then
        local cursor = ISMoveableCursor:new(getPlayer())
        getCell():setDrag(cursor, cursor.player)
        cursor:setMoveableMode(mode)
    end
end
