local cigarettesDialogues = {
    [1] = "I'd like to smoke so badly! If only I had some cigs...!",
    [2] = "I lost my fags again?! Goddamn it!",
    [3] = "A fag! A fag! My kingdom for a fag!"
}

local lightDialogues = {
    [1] = "Anybody got light?",
    [2] = "Where are my matches?",
    [3] = "Gotta search some corpses for a lighter..."
}

function getFirstItem(dictionary, inv, smokingItemType)
    local output
    for i, fullType in pairs(dictionary) do
        local identifier
        if useKey then
            identifier = i
        else
            identifier = fullType
        end
        output = inv:getFirstTypeRecurse(identifier)
        if output and (smokingItemType ~= "cigarettes" or output.getBaseHunger) then
            break
        else
            output = nil
        end
    end
    return output
end

EHK.smoke = function()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo, fireSourceContainer
    local cigarettes = getFirstItem(EHK.cigarettes, inv, "cigarettes")
    if not cigarettes then
        local cigarettesPack = getFirstItem(EHK.cigarettesPacks, inv)
        if not cigarettesPack then
            dialogueNo = ZombRand(3) + 1
            player:Say(cigarettesDialogues[dialogueNo])
            return
        else
            -- print("pack found ", cigarettesPack)
            local itemRecipes =
                RecipeManager.getUniqueRecipeItems(
                cigarettesPack,
                player,
                ISInventoryPaneContextMenu.getContainers(player)
            )
            local recipe
            if itemRecipes:size() > 0 then
                for i = 0, itemRecipes:size() - 1 do
                    recipe = itemRecipes:get(i)
                    if EHK.validRecipes[recipe:getName()] then
                        local ingredientName = recipe:getSource():get(0):getItems():get(0)
                        if ingredientName == cigarettesPack:getFullType() then
                            break
                        else
                            recipe = nil
                        end
                    else
                        recipe = nil
                    end
                end
            end
            if recipe then
                -- print("Recipe to be used: ", recipe:getName())
                -- print(recipe)
                cigarettes = RecipeManager.PerformMakeItem(recipe, cigarettesPack, player, EHK.getContainers())
                -- printFuckingNormalObject(cigarettes, "cigarettes")
                inv:AddItem(cigarettes)
            else
                -- print("No recipe found!")
                player:Say("Must remember to unpack cigarettes!")
                return
            end
        end
    end

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end

    fireSourceContainer = fireSource:getContainer()
    -- print("cigarettes", cigarettes)
    if cigarettes then
        ISInventoryPaneContextMenu.eatItem(cigarettes, 1, 0)
        local transferFireSource = ISInventoryTransferAction:new(player, fireSource, inv, fireSourceContainer)
        ISTimedActionQueue.add(transferFireSource)
    else
        print("ERROR! Cigarettes not obtained!")
    end
end

-- for fullType, _ in pairs(fireSourceDict) do
-- 1 Czy posiadamy instancję fullType dla fireSource?
-- jeśli NIE NEXT FULLTYPE!!!
-- jeśli tak
-- -- znajdź minimalną ilość
-- -- usuń wszystkie inne z main inventory
-- -- Queue smoke
-- -- Queue repack
-- -- Queue Reappear
-- -- break
-- oprogramować ON STOP dla reappearAction
-- -- jeśli nie - komunikat

-- for fullType, _ in pairs(cigarettesDict) do
-- 2 czy posiadamy instancję cigarettes - steps j.w.

-- czy
-- 1. Czy jest zapalniczka w main inventory?
-- jeśli tak - nic nie rób
-- jeśli nie - znajdź zapalniczkę z najniższym zużyciem i jeśli istnieje przepakuj do inventory
-- jeśli nie - powtórz dla zapałek

-- przepakuj z powrotem, jeśli istnieje
