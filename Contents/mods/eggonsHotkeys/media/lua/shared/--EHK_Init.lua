EHK = {
    keyConfigs = {},
    Options = {
        displayHotActions = true,
        displayFlexKey = true,
        -- separateKeyForCorpsePickup = false,
        tryToLoadCorpseToBackpackFirst = false,
        requireEquipCorpse = true,
        hideInventoryOnCollapse = false,
        pinInventoryOnExpand = true,
        secondUseOfBagHotkeyTogglesInventory = true,
        transferSelectedItemWithBagHotkeys = true,
        redirectKeyToKeyRing = true
    }
}

EHK_Plugin = {keyConfigs = {}}

function EHK_Plugin:AddConfigs(keyConfigs)
    for keyVar, cfg in pairs(keyConfigs) do
        if self.keyConfigs[keyVar] or EHK.keyConfigs[keyVar] then
            print("EHK ERROR: Tried to register key binding under existing name.")
        else
            self.keyConfigs[keyVar] = cfg
        end
    end
end

-- EggonsMU.config.enableEvent("OnBeforeItemTransfer")
