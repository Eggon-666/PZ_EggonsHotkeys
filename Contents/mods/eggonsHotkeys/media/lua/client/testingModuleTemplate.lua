local function getCarriedContainers()
    local backpacks = getPlayerInventory(0).backpacks
    local output = {}
    for i, carriedContainer in ipairs(backpacks) do
        if carriedContainer.inventory:getType() ~= "KeyRing" then
            table.insert(output, carriedContainer.inventory)
        end
    end
    return output
end

local function performActionOnItems(itemsList, actionFunction)
    for i, item in pairs(itemsList) do
        actionFunction(item)
    end
end

local function findLowestUseItemOfType(type, containerOrContainers, isSingleContainer)
    local containers = {}
    local lowestUseItem
    local lowestUsesNo = 1000000

    if isSingleContainer then
        table.insert(containers, containerOrContainers)
    else
        containers = containerOrContainers
    end

    for i, carriedContainer in ipairs(containers) do
        local itemsInContainer = carriedContainer:getItemsFromType(type)
        for j = 1, itemsInContainer:size() do
            -- for j, item in ipairs(itemsInContainer) do
            local item = itemsInContainer:get(j - 1)
            printFuckingNormalObject(item)
            local contentsLeft = item:getDelta()
            if contentsLeft and contentsLeft < lowestUsesNo then
                lowestUseItem = item
                lowestUsesNo = contentsLeft
            end
        end
    end
    return lowestUseItem
end

local function testFunction()
    local player = getPlayer()
    local inv = player:getInventory()
    local testAct = TestAction:new(player)
    ISTimedActionQueue.add(testAct)
    -- local items = inv:getItemsFromType("Lighter")
    -- local lighter = inv:getItemFromType("Lighter")
    local cigarettes = inv:getFirstTypeRecurse("Cigarettes")

    -- inv:DoRemoveItem(lighter)
    -- ISInventoryPaneContextMenu.eatItem(cigarettes, 1, 0)

    local carriedContainers = getCarriedContainers()
    local lowestUseItem = findLowestUseItemOfType("Lighter", carriedContainers, false)
    if not lowestUseItem then
        lowestUseItem = findLowestUseItemOfType("Matches", carriedContainers, false)
    end
end

local function keyPressedHandler(key)
    print("key: ", key)
    if key ~= 156 then -- 156 = ENTER
        return
    end
    testFunction()
end
Events.OnKeyPressed.Add(keyPressedHandler)

function printFuckingNormalObject(uselessAndPatheticLuaTable, message)
    message = message or ""
    if type(uselessAndPatheticLuaTable) ~= "table" then
        print("Not a table: " .. message .. ", but " .. type(uselessAndPatheticLuaTable))
        print(uselessAndPatheticLuaTable)
        return
    end
    local result = "\n "
    if message then
        result = result .. "******** " .. message .. " ***********"
    end
    result = result .. "\n{"
    for key, value in pairs(uselessAndPatheticLuaTable) do
        result = result .. "\n    " .. tostring(key) .. ": " .. tostring(value) .. ","
    end
    result = result .. "\n}"
    print(result)
end
