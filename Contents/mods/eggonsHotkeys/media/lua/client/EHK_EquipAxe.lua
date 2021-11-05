local axes = {
    [1] = "Base.WoodAxe",
    [2] = "Base.Axe",
    [3] = "Base.HandAxe"
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
    local axe

    local PHI = player:getPrimaryHandItem()

    if predicateChopTree(PHI) then
        axe = PHI
    else
        -- zamienić na searcz by best type
        -- axe = inv:getFirstEvalRecurse(predicateChopTree)
    end

    if axe then
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
