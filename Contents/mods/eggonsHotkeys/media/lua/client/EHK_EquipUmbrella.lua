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

local function switchUmbrella(umbrella, equip)
    equip = equip or false
    print("umbrella? ", umbrella)
    print("Equip umbrella? ", equip)
    local player = getPlayer()
    local inv = player:getInventory()
    local SHI = player:getSecondaryHandItem()
    local fullType = umbrella:getFullType()
    local isOpened = umbrella:isProtectFromRainWhileEquipped()
    local descendant
    if isOpened then
        descendant = openedUmbrellas[fullType]
    else
        descendant = closedUmbrellas[fullType]
    end
    local switchedUmbrella = inv:AddItem(descendant)
    if SHI == umbrella then
        ISTimedActionQueue.add(ISUnequipAction:new(player, SHI, 0))
        local openAction =
            EHK.UniversalAction:new(
            player,
            umbrella,
            function(self)
                inv:DoRemoveItem(SHI)
            end
        )
        ISTimedActionQueue.add(openAction)
    end
    if equip then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, switchedUmbrella, 50, false, false))
    end
    return switchedUmbrella
end

local function predicateUmbrella(item)
    local output = item:getBreakSound() == "UmbrellaBreak" or item:isProtectFromRainWhileEquipped()
    print("Is item " .. item:getDisplayName() .. " umbrella? ", output)
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

    if SHI and predicateUmbrella(SHI) then
        switchedUmbrella = switchUmbrella(SHI)
        if SHI:isProtectFromRainWhileEquipped() then -- equipped and open
            local previousItem = PMD.EHK.previousItem
            if previousItem then
                ISInventoryPaneContextMenu.equipWeapon(
                    previousItem,
                    PMD.EHK.previousWasInBothHands,
                    PMD.EHK.previousWasInBothHands,
                    player:getPlayerNum()
                )
            end
            if PMD.EHK.previousContainer and switchedUmbrella then
                local repack = ISInventoryTransferAction:new(player, switchedUmbrella, inv, PMD.EHK.previousContainer)
                ISTimedActionQueue.add(repack)
            end
            PMD.EHK = {}
        else -- equipped and closed
            -- instantly equip switched(opened) umbrella
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, umbrella, 10, false, false))
        end
    else
        local umbrella = inv:getFirstEvalRecurse(predicateUmbrella)
        if umbrella then
            local PHI = player:getPrimaryHandItem()
            PMD.EHK.previousContainer = umbrella:getContainer()
            PMD.EHK.previousItem = SHI
            PMD.EHK.previousWasInBothHands = SHI and SHI == PHI
            print("FullType: ", umbrella:getFullType())

            if closedUmbrellas[umbrella:getFullType()] then
                -- ISTimedActionQueue.add(openAction)
                print("Move to inv closed umbrella")
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
            else
                print("moving opened umbrella")
                print("two handed ", umbrella:isTwoHandWeapon())
                ISInventoryPaneContextMenu.equipWeapon(umbrella, false, false, player:getPlayerNum())
            end
        else
            player:Say("I must have left the umbrella home.")
        end
    end
end
