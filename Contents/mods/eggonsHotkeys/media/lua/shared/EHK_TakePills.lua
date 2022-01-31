EHK = EHK or {}

function EHK.takePills(fullType)
    local player = getPlayer()
    local inv = player:getInventory()
    local pills = inv:getFirstTypeRecurse(fullType)
    if pills then
        local sourceContainer = pills:getContainer()
        ISInventoryPaneContextMenu.takePill(pills, 0)
        local transferPillsBack = ISInventoryTransferAction:new(player, pills, inv, sourceContainer)
        ISTimedActionQueue.add(transferPillsBack)
    else
        player:Say("I'm out of pills! Goddamn it!")
    end
end

function EHK.takeBetaBlockers()
    EHK.takePills("Base.PillsBeta")
end
function EHK.takePainKillers()
    EHK.takePills("Base.Pills")
end
function EHK.takeVitamins()
    EHK.takePills("Base.PillsVitamins")
end
