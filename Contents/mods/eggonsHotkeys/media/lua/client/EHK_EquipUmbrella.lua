local openedUmbrellas = {
    ["Base.UmbrellaBlack"] = "Base.ClosedUmbrellaBlack",
    ["Base.UmbrellaWhite"] = "Base.ClosedUmbrellaWhite",
    ["Base.UmbrellaBlue"] = "Base.ClosedUmbrellaBlue",
    ["Base.UmbrellaRed"] = "Base.ClosedUmbrellaRed"
}
local closedUmbrellas = {
    ["Base.ClosedUmbrellaBlack"] = "Base.UmbrellaBlack",
    ["Base.ClosedUmbrellaWhite"] = "Base.UmbrellaWhite",
    ["Base.ClosedUmbrellaBlue"] = "Base.UmbrellaBlue",
    ["Base.ClosedUmbrellaRed"] = "Base.UmbrellaRed"
}

local function switchUmbrella(umbrella, equip, carriedPrimary, carriedSecondary)
    equip = equip or false
    -- print("umbrella? ", umbrella)
    -- print("Equip umbrella? ", equip)
    local player = getPlayer()
    local inv = player:getInventory()

    local fullType = umbrella:getFullType()
    local isOpened = umbrella:isProtectFromRainWhileEquipped()
    local descendant
    local switchedUmbrella
    if isOpened then
        descendant = openedUmbrellas[fullType]
    else
        descendant = closedUmbrellas[fullType]
    end
    switchedUmbrella = inv:AddItem(descendant)
    -- print("Adding switched item to inv")
    if carriedSecondary then
        local SHI = player:getSecondaryHandItem()
        ISTimedActionQueue.add(ISUnequipAction:new(player, SHI, 50))
        local removeAction =
            EHK.UniversalAction:new(
            player,
            umbrella,
            function(self)
                -- print("removing SHI: ", SHI)
                -- print("Container: ", SHI:getContainer())
                inv:DoRemoveItem(SHI)
            end
        )
        ISTimedActionQueue.add(removeAction)
    end
    if carriedPrimary and not carriedSecondary then
        local PHI = player:getPrimaryHandItem()
        -- print("Unequipping primary: ", PHI)
        ISTimedActionQueue.add(ISUnequipAction:new(player, PHI, 50))
        local removeAction =
            EHK.UniversalAction:new(
            player,
            umbrella,
            function(self)
                -- print("removing PHI: ", PHI)
                -- print("Container: ", PHI:getContainer())
                inv:DoRemoveItem(PHI)
            end
        )
        ISTimedActionQueue.add(removeAction)
    end
    if equip then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, switchedUmbrella, 50, false, false))
    end
    return switchedUmbrella
end

local function predicateUmbrella(item)
    local fullType = item:getFullType()
    local output = false
    if openedUmbrellas[fullType] or closedUmbrellas[fullType] then
        output = true
    end
    -- item:getBreakSound() == "UmbrellaBreak" or item:isProtectFromRainWhileEquipped()
    -- print("Is item " .. item:getFullType() .. " umbrella? ", output)
    -- print("openedUmbrellas[fullType] ", openedUmbrellas[fullType])
    -- print("closedUmbrellas[fullType] ", closedUmbrellas[fullType])
    return output
end

function EHK.equipUmbrella()
    local player = getPlayer()
    local PMD = player:getModData()
    local closedUmbrella, openedUmbrella, switchedUmbrella, recipe
    if not PMD.EHK then
        PMD.EHK = {}
    end
    local inv = player:getInventory()

    local SHI = player:getSecondaryHandItem()
    local PHI = player:getPrimaryHandItem()
    local carriedUmbrella
    local carriedPrimary, carriedSecondary = false, false
    if (SHI and predicateUmbrella(SHI)) then
        carriedUmbrella = SHI
        carriedSecondary = true
    end
    if (PHI and predicateUmbrella(PHI)) then
        if not carriedSecondary then
            carriedUmbrella = PHI
        end
        carriedPrimary = true
    end

    if carriedUmbrella then
        -- print("Carried umbrella detectd")

        switchedUmbrella = switchUmbrella(carriedUmbrella, false, carriedPrimary, carriedSecondary)
        if openedUmbrellas[carriedUmbrella:getFullType()] then -- equipped and open
            -- print("Carried umbrella is opened")
            local previousItem = PMD.EHK.previousItem
            if previousItem then
                -- print("previous item present")
                ISInventoryPaneContextMenu.equipWeapon(
                    previousItem,
                    PMD.EHK.previousWasInBothHands,
                    PMD.EHK.previousWasInBothHands,
                    player:getPlayerNum()
                )
            end
            if PMD.EHK.previousContainer then
                -- print("previous container present")
                local repack = ISInventoryTransferAction:new(player, switchedUmbrella, inv, PMD.EHK.previousContainer)
                ISTimedActionQueue.add(repack)
            end
            PMD.EHK = {}
        else -- equipped and closed
            -- print("Carried umbrella is closed")
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, switchedUmbrella, 10, false, false))
        end
    else
        local umbrella = inv:getFirstEvalRecurse(predicateUmbrella)
        if umbrella then
            PMD.EHK.previousContainer = umbrella:getContainer()
            PMD.EHK.previousItem = SHI
            PMD.EHK.previousWasInBothHands = SHI and SHI == PHI

            if closedUmbrellas[umbrella:getFullType()] then
                -- ISTimedActionQueue.add(openAction)
                -- print("Move to inv closed umbrella")
                local moveToInventory = ISInventoryTransferAction:new(player, umbrella, PMD.EHK.previousContainer, inv)
                ISTimedActionQueue.add(moveToInventory)
                -- problem, że jak otarte w bag to może zostać otwarty po cancel action
                local openAction =
                    EHK.UniversalAction:new(
                    player,
                    umbrella,
                    function(self)
                        switchUmbrella(umbrella, true)
                    end
                )
                ISTimedActionQueue.add(openAction)
                local removeOldAction =
                    EHK.UniversalAction:new(
                    player,
                    umbrella,
                    function(self)
                        inv:DoRemoveItem(umbrella)
                    end
                )
                ISTimedActionQueue.add(removeOldAction)
            else
                -- print("moving opened umbrella")
                -- print("two handed ", umbrella:isTwoHandWeapon())
                ISInventoryPaneContextMenu.equipWeapon(umbrella, false, false, player:getPlayerNum())
            end
        else
            player:Say("I must have left the umbrella home.")
        end
    end
end
