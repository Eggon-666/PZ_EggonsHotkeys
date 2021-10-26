EHK = EHK or {}

function EHK.takePills(fullType)
    local player = getPlayer()
    local inv = player:getInventory()
    local pills = inv:getFirstTypeRecurse(fullType)
    local sourceContainer = pills:getContainer()
    ISInventoryPaneContextMenu.takePill(pills, 0)
    if pills then
        local transferPillsBack = ISInventoryTransferAction:new(player, pills, inv, sourceContainer)
        ISTimedActionQueue.add(transferPillsBack)
    end
end

function EHK.takeBetaBlockers()
    EHK.takePills("Base.PillsBeta")
end
function EHK.takePainKillers()
    EHK.takePills("Base.Pills")
end
