EHK = EHK or {}
local function extinguishCursorInit(self)
    local bo = ISExtinguishCursor:new(self.character, self.item)
    getCell():setDrag(bo, bo.player)
end

local extinguishers = {
    [1] = "Base.Extinguisher",
    [2] = "Base.Sandbag",
    [3] = "Base.Gravelbag",
    [4] = "Base.Dirtbag"
}

local function predicateWaterSource(item)
    return item:isWaterSource()
end

local function getExtinguisher()
    local player = getPlayer()
    local inv = player:getInventory()
    local extinguisher
    for i, fullType in ipairs(extinguishers) do
        extinguisher = inv:getFirstTypeRecurse(fullType)
        if extinguisher then
            break
        end
    end
    if not extinguisher then
        extinguisher = inv:getFirstEvalRecurse(predicateWaterSource)
    end
    return extinguisher
end

function EHK.equipExtinguisher()
    local player = getPlayer()
    local inv = player:getInventory()
    local extinguisher = getExtinguisher(player)
    if extinguisher then
        transferToInventory = ISInventoryTransferAction:new(player, extinguisher, extinguisher:getContainer(), inv)
        ISTimedActionQueue.add(transferToInventory)
        local CursorInit = EHK.UniversalAction:new(player, extinguisher, extinguishCursorInit)
        ISTimedActionQueue.add(CursorInit)
    else
        player:Say("I don't have any extinguishing items.")
    end
end
