local DEBUG = getCore():getDebug()
if DEBUG then
    local function addItems()
        local player = getPlayer()
        local inv = player:getInventory()
        -- inv:AddItem("SM.Matches")
        local testItem
        -- for i, fullType in pairs(EHK.cigarettesPacks) do
        --     testItem = getScriptManager():getItem(fullType)
        --     if testItem and type(testItem) ~= "string" then
        --         inv:AddItem(fullType)
        --     end
        -- end
        -- testItem = getScriptManager():getItem(EHK.cigarettes[8])
        -- if testItem and type(testItem) ~= "string" then
        --     inv:AddItem(EHK.cigarettes[1])
        --     inv:AddItem(EHK.cigarettes[1])
        --     inv:AddItem(EHK.cigarettesPacks[3])
        --     inv:AddItem("CigaretteMod.CigaretteCarton")
        -- end
        inv:AddItem("Base.CorpseMale")
        inv:AddItem("Base.CorpseFemale")
    end
    local function getContainers()
        -- get all the surrounding inventory of the player, gonna check for the item in them too
        local containerList = ArrayList.new()
        local c = {}
        for i, v in ipairs(getPlayerInventory(0).inventoryPane.inventoryPage.backpacks) do
            containerList:add(v.inventory)
            c[#c + 1] = v.inventory
        end
        -- for i, v in ipairs(getPlayerLoot(0).inventoryPane.inventoryPage.backpacks) do
        --     containerList:add(v.inventory)
        -- end
        return containerList
    end

    local function testFn(item)
        print("Test function")
        -- EggonsMU.printFuckingNormalObject(EggonsMU.functions.getInventory(), "GetPlInv")
        EggonsMU.printFuckingNormalObject(getPlayer():getInventory():getItems(), "GetPlayer getInventory getItems")
    end
    local function printEvos(item)
        local player = getPlayer()
        local containers = ISInventoryPaneContextMenu.getContainers(player)
        local inv = player:getInventory()
        local recipe = ScriptManager.instance:getRecipe("CigaretteMod.Open Packet")

        printFuckingNormalObject(recipe, "recipe inevo")
        cigarettes = RecipeManager.PerformMakeItem(recipe, item, player, getContainers())
        printFuckingNormalObject(cigarettes, "cigarettes inevo")

        inv:AddItem(cigarettes)
    end

    local function lootContainers()
        for i, v in ipairs(getPlayerLoot(0).inventoryPane.inventoryPage.backpacks) do
            print("Container TYpe ", v.inventory:getType())
            printFuckingNormalObject(v.inventory)
        end
    end

    local function decreaseWeight(item)
        item:setActualWeight(5)
    end

    local function addDebugOptions(player, context, items)
        local item
        if items[1].items then
            item = items[1].items[1]
        else -- if right-clicked in hotbar
            item = items[1]
        end

        context:addOption("Add items", item, addItems)
        context:addOption("Print loot container", item, lootContainers)
        -- context:addOption("Print evos", item, printEvos)
        context:addOption("Test", item, testFn)
        -- context:addOption("Decrease weight", item, decreaseWeight)
    end
    Events.OnFillInventoryObjectContextMenu.Add(addDebugOptions)

-- czy niesiemy corpse?
-- -- TAK niesiemy corpse
-- -- -- Czy jest bin w lootInventory i czy jest w nim miejsce
-- -- -- -- TAK jest pusty bin
-- -- -- -- -- przetransferuj corpse do bin
-- -- -- -- -- Opróżnij bin
-- -- -- -- -- ZAKOŃCZ
-- -- -- -- ELSE GOTO NEXT
-- -- -- Czy jest grave i czy jest w nim miejsce?
-- -- -- -- TAK, jest grave z miejscem
-- -- -- -- -- pochowaj corpse
-- -- -- -- -- ZAKOŃCZ
-- -- -- -- ELSE GOTO NEXT
-- -- -- ELSE
-- -- -- -- Drop corpse
-- -- NIE niesiemy corpse
-- -- -- Czy leży corpse na ziemi?
-- -- -- -- TAK leży corpse na ziemi
-- -- -- -- -- podnieś corpse
-- -- -- -- NIE leży corpse na ziemi
-- -- -- -- -- powiedz coś
end
