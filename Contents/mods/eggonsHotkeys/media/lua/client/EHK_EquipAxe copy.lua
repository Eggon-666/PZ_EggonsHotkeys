local sledgehammers = {
    ["Base.Sledgehammer"] = true,
    ["Base.Sledgehammer2"] = true
}

local function predicateUmbrela(item)
    return item:getDisplayName() == "Umbrella"
end

function EHK.equipUmbrella()
    local player = getPlayer()
    local inv = player:getInventory()
    local axe = inv:getFirstEvalRecurse(predicateUmbrela)

    -- local SHI = player:getSecondaryHandItem()

    -- local equippedPrimary = false
    -- local equippedSecondary = false

    -- local sledge
    -- if PHI and sledgehammers[PHI:getFullType()] then
    --     sledge = PHI
    -- else
    --     -- znajdź sledge z listy
    --     for fullType, _ in pairs(sledgehammers) do
    --         sledge = inv:getFirstTypeRecurse(fullType)
    --         if sledge then
    --             break
    --         end
    --     end
    -- end
    -- if sledge and sledge ~= PHI then
    --     ISInventoryPaneContextMenu.equipWeapon(sledge, true, true, player:getPlayerNum()) --(weapon, primary, twoHands, player)
    -- elseif sledge and sledge == PHI then
    --     -- nufin
    -- else
    --     player:Say("Where have I put my sledgehammer?")
    --     return
    -- end
    if axe then
        local PHI = player:getPrimaryHandItem()
        if PHI ~= axe then
            ISInventoryPaneContextMenu.equipWeapon(axe, true, axe:isTwoHandWeapon(), player:getPlayerNum())
        end
        local cursorAction = EHK.CursorAction:new(player, axe, axeCursorInit)
        ISTimedActionQueue.add(cursorAction)
    end
end

-- local keyConfigs = {
--     sledgehammer = {
--         action = equipSledge,
--         keyCode = 0
--     }
-- }
-- if EHK_Plugin then
--     EHK_Plugin:AddConfigs(keyConfigs)
-- end
