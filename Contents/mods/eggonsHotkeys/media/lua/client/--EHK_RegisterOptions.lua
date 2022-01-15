local optionsSources = {}

if ModOptions and ModOptions.getInstance then
    local function applyModOptions(updateData)
        local newValues = updateData.settings.options
        EHK.Options.displayHotActions = newValues.displayHotActions
        EHK.Options.displayFlexKey = newValues.displayFlexKey
        -- EHK.Options.separateKeyForCorpsePickup = newValues.separateKeyForCorpsePickup
        EHK.Options.tryToLoadCorpseToBackpackFirst = newValues.tryToLoadCorpseToBackpackFirst
        EHK.Options.requireEquipCorpse = newValues.requireEquipCorpse
        EHK.Options.hideInventoryOnCollapse = newValues.hideInventoryOnCollapse
        EHK.Options.pinInventoryOnExpand = newValues.pinInventoryOnExpand
        EHK.Options.secondUseOfBagHotkeyTogglesInventory = newValues.secondUseOfBagHotkeyTogglesInventory
        EHK.Options.transferSelectedItemWithBagHotkeys = newValues.transferSelectedItemWithBagHotkeys
        EHK.Options.redirectKeyToKeyRing = newValues.redirectKeyToKeyRing
    end
    local SETTINGS = {
        options_data = {
            displayHotActions = {
                default = true,
                name = "Display HotActions in the context menu",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            displayFlexKey = {
                default = true,
                name = "Display FlexKey selection in the context menu",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            -- separateKeyForCorpsePickup = {
            --     default = false,
            --     name = "Enable separate key for picking up corpses",
            --     OnApplyMainMenu = applyModOptions,
            --     OnApplyInGame = applyModOptions
            -- },
            tryToLoadCorpseToBackpackFirst = {
                default = false,
                name = "Pack corpse to backpack if possible",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            requireEquipCorpse = {
                default = true,
                name = "Require corpse to be equipped when holding",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            hideInventoryOnCollapse = {
                default = false,
                name = "Hide inventory bar when collapsing",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            pinInventoryOnExpand = {
                default = true,
                name = "Pin inventory window when expanding",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            secondUseOfBagHotkeyTogglesInventory = {
                default = true,
                name = "Close inventory with active bag hotkey",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            transferSelectedItemWithBagHotkeys = {
                default = true,
                name = "Transfer selected item to bag when using its hotkey",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            redirectKeyToKeyRing = {
                default = true,
                name = "Redirect transferred keys to key ring",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            }
        },
        mod_id = "eggonsHotkeys",
        mod_shortname = "EHK",
        mod_fullname = "Eggon's Hotkeys"
    }
    -- for optionName, cfg in pairs(optionsSources) do
    --     for i, valueOrCfg in ipairs(cfg.source) do
    --         local appliedValue
    --         if cfg.complexSource then
    --             appliedValue = valueOrCfg.name
    --         else
    --             appliedValue = valueOrCfg
    --         end
    --         SETTINGS.options_data[optionName][i] = appliedValue
    --     end
    -- end
    local optionsInstance = ModOptions:getInstance(SETTINGS)
    ModOptions:loadFile()
    Events.OnGameStart.Add(
        function()
            applyModOptions({settings = SETTINGS})
        end
    )
end
