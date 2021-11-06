local sledgehammers = {
    ["Base.Sledgehammer"] = true,
    ["Base.Sledgehammer2"] = true
}

local function demolishCursorInit(self)
    local bo = ISDestroyCursor:new(self.character, false, self.item)
    getCell():setDrag(bo, bo.player)
end

local function predicatSledgehammer(item)
    return sledgehammers[item:getFullType()] and not item:isBroken()
end

function EHK.equipSledgehammer()
    local player = getPlayer()
    local inv = player:getInventory()

    local SHI = player:getSecondaryHandItem()
    local PHI = player:getPrimaryHandItem()
    local equippedPrimary = false
    local equippedSecondary = false

    local sledgehammer
    if PHI and sledgehammers[PHI:getFullType()] and not PHI:isBroken() then
        sledgehammer = PHI
    else
        -- znajdź sledge z listy
        for fullType, _ in pairs(sledgehammers) do
            sledgehammer = inv:getFirstEvalRecurse(predicatSledgehammer)
            if sledgehammer then
                break
            end
        end
    end
    if sledgehammer and sledgehammer ~= PHI then
        ISInventoryPaneContextMenu.equipWeapon(sledgehammer, true, true, player:getPlayerNum()) --(weapon, primary, twoHands, player)
    elseif sledgehammer and sledgehammer == PHI then
        -- nufin
    else
        player:Say("Where have I put my sledgehammer?")
        return
    end
    local UniversalAction = EHK.UniversalAction:new(player, sledgehammer, demolishCursorInit)
    ISTimedActionQueue.add(UniversalAction)
end

-- local keyConfigs = {
--     sledgehammer = {
--         action = equipSledgehammer,
--         keyCode = 0
--     }
-- }
-- if EHK_Plugin then
--     EHK_Plugin:AddConfigs(keyConfigs)
-- end
