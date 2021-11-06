local axes = {
    [1] = "Base.WoodAxe",
    [2] = "Base.Axe",
    [3] = "Base.HandAxe",
    [4] = "Base.AxeStone"
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

    if PHI and predicateChopTree(PHI) then
        axe = PHI
    else
        for i, fullType in ipairs(axes) do
            axe = inv:getFirstTypeRecurse(fullType)
            if axe and not axe:isBroken() then
                break
            else
                axe = nil -- reset if broken
            end
        end
        if not axe then -- hail mary for modded axe
            axe = inv:getFirstEvalRecurse(predicateChopTree)
        end
    end

    if axe then
        if PHI ~= axe then
            ISInventoryPaneContextMenu.equipWeapon(axe, true, axe:isTwoHandWeapon(), player:getPlayerNum())
        end
        local UniversalAction = EHK.UniversalAction:new(player, axe, axeCursorInit)
        ISTimedActionQueue.add(UniversalAction)
    else
        player:Say("Where have I put my axe?")
        return
    end
end
