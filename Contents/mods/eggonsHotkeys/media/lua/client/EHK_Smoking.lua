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

function getFirstItem(dictionary, inv)
    local output
    for i, fullType in ipairs(dictionary) do
        output = inv:getFirstTypeRecurse(fullType)
        if output then
            break
        end
    end
    return output
end

EHK.smoke = function()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo, fireSourceContainer
    local cigarettes = getFirstItem(EHK.cigarettes, inv)
    if not cigarettes then
        dialogueNo = ZombRand(3) + 1
        player:Say(cigarettesDialogues[dialogueNo])
        return
    end

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end

    fireSourceContainer = fireSource:getContainer()

    ISInventoryPaneContextMenu.eatItem(cigarettes, 1, 0)
    local transferFireSource = ISInventoryTransferAction:new(player, fireSource, inv, fireSourceContainer)
    ISTimedActionQueue.add(transferFireSource)
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
