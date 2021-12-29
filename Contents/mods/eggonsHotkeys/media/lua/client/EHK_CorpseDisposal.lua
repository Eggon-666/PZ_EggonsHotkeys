local corpses = {
    ["Base.CorpseFemale"] = true,
    ["Base.CorpseMale"] = true
}

local function clearCorpseInBin(self)
    local corpse = self.item
    local bin = corpse:getContainer()
    bin:DoRemoveItem(corpse)
end

local function getSpecificLootContainer(type)
    local loot = getPlayerLoot(getPlayer():getPlayerNum())
    local backpacks = loot.backpacks
    local output
    for i, button in ipairs(backpacks) do
        if button.inventory:getType() == type then
            output = button.inventory
            break
        end
    end
    return output
end

local function getCorpseFromGround()
    local output = getSpecificLootContainer("inventorymale") or getSpecificLootContainer("inventoryfemale")
    return output
end

local function getAvailableBin(corpse)
    local player = getPlayer()
    local loot = getPlayerLoot(player:getPlayerNum())
    local backpacks = loot.backpacks
    local bin
    local tooSmallBin = false
    for i, button in ipairs(backpacks) do
        if button.inventory:getType() == "bin" then
            bin = button.inventory
            if bin:hasRoomFor(player, corpse) then
                binHasRoomFor = true
                break
            else
                tooSmallBin = true
                bin = nil
            end
        end
    end
    return bin
end

local function getAvailableGrave()
    -- print("Looking for a grave")
    local player = getPlayer()
    local square = player:getSquare()
    local specialObjects = square:getSpecialObjects()
    local specialObjectsCount = specialObjects:size()
    local grave
    if specialObjectsCount > 0 then
        for i = 0, specialObjectsCount - 1 do
            local SO = specialObjects:get(i)
            if SO:getName() == "EmptyGraves" and not ISEmptyGraves.isGraveFilledIn(SO) then
                grave = SO
                break
            end
        end
    end
    return grave
end

local function predicateCorpse(item)
    local fullType = item:getFullType()
    return corpses[fullType]
end

EHK.corpseDisposal = function(keyPressedString)
    local actionCodes = {
        [tostring(getCore():getKey("corpseDisposal"))] = "pickup",
        [tostring(getCore():getKey("corpseDrop"))] = "drop"
    }
    local action = actionCodes[keyPressedString]
    local pickUp, drop = true, true
    if EHK.Options.separateKeyForCorpsePickup then
        if action == "pickup" then
            drop = false
        elseif action == "drop" then
            pickUp = false
        end
    -- czy działa, kiedy no key set?
    end
    -- print("Starting corpse disposal")
    local player = getPlayer()
    local playerNum = player:getPlayerNum()
    local inv = player:getInventory()
    local loot = getPlayerLoot(playerNum)

    local corpse = inv:getFirstEvalRecurse(predicateCorpse)
    local floor = getSpecificLootContainer("floor")
    local transferTheCorpse

    if drop and corpse then -- CARRYING CORPSE
        local corpseContainer = corpse:getContainer()
        local isCorpseEquipped = player:isEquipped(corpse)
        -- print("Corpse found in inventory")
        -- Check if bin is available. Transfer to bin and clear.
        local bin = getAvailableBin(corpse)
        if bin then
            -- print("Available bin found")
            transferTheCorpse = ISInventoryTransferAction:new(player, corpse, corpseContainer, bin)
            ISTimedActionQueue.add(transferTheCorpse)
            local ClearCorpseInBin = EHK.UniversalAction:new(player, corpse, clearCorpseInBin, 15)
            ISTimedActionQueue.add(ClearCorpseInBin)
            return
        end
        -- print("Available bin NOT found")
        -- check if grave available
        local grave = getAvailableGrave()
        if grave then
            -- print("Available grave found")
            if corpseContainer:getType() ~= "none" then
                transferTheCorpse = ISInventoryTransferAction:new(player, corpse, corpseContainer, inv)
                ISTimedActionQueue.add(transferTheCorpse)
            end
            local buryTheCorpse = ISBuryCorpse:new(playerNum, grave, 80)
            ISTimedActionQueue.add(buryTheCorpse)
            return
        end
        -- print("Available grave NOT found")
        if isCorpseEquipped then
            ISInventoryPaneContextMenu.unequipItem(corpse, playerNum)
        else
            -- print("container:", corpse:getContainer())
            transferTheCorpse = ISInventoryTransferAction:new(player, corpse, corpseContainer, floor)
            ISTimedActionQueue.add(transferTheCorpse)
        end
    elseif drop then
        player:Say("I don't carry any corpses.")
    else -- PICK UP
        -- print("Corpse NOT found in inventory")
        -- Is a corpse on the ground?
        corpse = getCorpseFromGround()
        if corpse then
            -- print("Corpse found on the ground")
            if EHK.Options.tryToLoadCorpseToBackpackFirst then
                local backpack = getPlayer():getClothingItem_Back()
                if backpack and EHK.canFitItem(backpack, corpse) then
                    transferTheCorpse = ISInventoryTransferAction:new(player, corpse, corpseContainer, backpack)
                    ISTimedActionQueue.add(transferTheCorpse)
                else -- check if already holding
                    local PHI = player:getPrimaryHandItem()
                    if PHI and corpses[PHI:getFullType()] then
                    end
                end
            else
                ISTimedActionQueue.add(ISGrabCorpseAction:new(player, corpse:getParent(), 50))
            end
        else -- NO CORPSE ON THE FLOOR
            -- print("Corpse NOT found on the ground")
            player:Say("There are no corpses within my reach.")
        end
    end
end
