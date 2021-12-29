function EHK.getContainers()
    local containerList = ArrayList.new()
    local c = {}
    for i, v in ipairs(getPlayerInventory(0).inventoryPane.inventoryPage.backpacks) do
        containerList:add(v.inventory)
        c[#c + 1] = v.inventory
    end
    return containerList
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
