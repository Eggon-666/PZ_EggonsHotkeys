local sledgehammers = {
    ["Base.Sledgehammer"] = true,
    ["Base.Sledgehammer2"] = true
}

local function axeCursorInit(self)
    local bo = ISChopTreeCursor:new("", "", self.character)
    getCell():setDrag(bo, bo.player)
end

local function predicateChopTree(item)
    return not item:isBroken() and item:hasTag("ChopTree")
end

function EHK.equipAxe()
    local player = getPlayer()
    local inv = player:getInventory()
    local axe = inv:getFirstEvalRecurse(predicateChopTree)

    local SHI = player:getSecondaryHandItem()
    local PHI = player:getPrimaryHandItem()
    local equippedPrimary = false
    local equippedSecondary = false

    local sledge
    if PHI and sledgehammers[PHI:getFullType()] then
        sledge = PHI
    else
        -- znajdź sledge z listy
        for fullType, _ in pairs(sledgehammers) do
            sledge = inv:getFirstTypeRecurse(fullType)
            if sledge then
                break
            end
        end
    end
    if sledge and sledge ~= PHI then
        ISInventoryPaneContextMenu.equipWeapon(sledge, true, true, player:getPlayerNum()) --(weapon, primary, twoHands, player)
    elseif sledge and sledge == PHI then
        -- nufin
    else
        player:Say("Where have I put my sledgehammer?")
        return
    end
    local cursorAction = EHK.CursorAction:new(player, axe, axeCursorInit)
    ISTimedActionQueue.add(cursorAction)
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
