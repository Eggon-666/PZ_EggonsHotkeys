EHK = EHK or {}

local function turnOffLighter(self)
    self.item:setActivated(false)
end

function EHK.equipMolotov()
    local player = getPlayer()
    local inv = player:getInventory()
    local molotov, fireSource

    -- czy molotov jest primary lub secondary
    -- czy ogień jest primary lub secondary
    -- jeśli tak, to zostaw, jeśli nie znajdć i equip
    -- zapalniczkę zgaś

    local SHI = player:getSecondaryHandItem()
    local PHI = player:getPrimaryHandItem()
    if (PHI and PHI:getFullType() == "Base.Molotov") then
        molotov = PHI
    else
        PHI = nil
        molotov = inv:getFirstTypeRecurse("Base.Molotov")
        print("molotov, ", molotov)
    end
    if (SHI and SHI:getFullType() == "Base.Lighter") then
        fireSource = SHI
    else
        SHI = nil
        fireSource = inv:getFirstTypeRecurse("Base.Lighter")
    end

    if not molotov then
        player:Say("Where's my molotov? Have I drunk it yesterday?")
        return
    elseif not fireSource then
        player:Say("Forgot my lighter? Dammit!")
        return
    end

    if not PHI then
        ISInventoryPaneContextMenu.equipWeapon(molotov, true, false, player:getPlayerNum()) -- (weapon, primary, twoHands, player)
    end
    if not SHI then
        ISInventoryPaneContextMenu.equipWeapon(fireSource, false, false, player:getPlayerNum()) -- (weapon, primary, twoHands, player)
    end
    local TurnOffLighter = EHK.UniversalAction:new(player, fireSource, turnOffLighter)
    ISTimedActionQueue.add(TurnOffLighter)
end
