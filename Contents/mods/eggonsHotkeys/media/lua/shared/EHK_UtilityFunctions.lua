function EHK.getContainers()
    local containerList = ArrayList.new()
    local c = {}
    for i, v in ipairs(getPlayerInventory(0).inventoryPane.inventoryPage.backpacks) do
        containerList:add(v.inventory)
        c[#c + 1] = v.inventory
    end
    return containerList
end

function EHK.findAvailableContainer(item, player)
    local container = player:getClothingItem_Back()
    if container and EHK.canFitItem(container, item) then
        return container
    end
    container = player:getSecondaryHandItem()
    if (container and instanceof(container, "ItemContainer") and EHK.canFitItem(container, item)) then
        return container
    end
    if EHK.Options.requireEquipCorpse then
        local SHI = player:getSecondaryHandItem()
        if SHI and EHK.corpses[SHI:getFullType()] then
            return false
        else
            return true
        end
    else
        container = player:getInventory()
        if EHK.canFitItem(container, item) then
            return container
        end
    end
    return false
end

function EHK.canFitItem(container, item)
    local capacity = container:getCapacity()
    local usedCapacity = container:getContentsWeight()
    local freeCapacity = capacity - usedCapacity
    local itemWeight = item:getWeight()
    if itemWeight > freeCapacity then
        return false
    else
        return true
    end
end
