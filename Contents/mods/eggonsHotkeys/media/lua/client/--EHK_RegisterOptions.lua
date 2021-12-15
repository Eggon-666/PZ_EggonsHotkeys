local optionsSources = {}

if ModOptions and ModOptions.getInstance then
    local function applyModOptions(updateData)
        local newValues = updateData.settings.options
        EHK.Options.displayHotActions = newValues.displayHotActions
        EHK.Options.displayFlexKey = newValues.displayFlexKey
        EHK.Options.separateKeyForCorpseDrop = newValues.separateKeyForCorpseDrop
        EHK.Options.tryToLoadCorpseToBackpackFirst = newValues.tryToLoadCorpseToBackpackFirst
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
            separateKeyForCorpseDrop = {
                default = false,
                name = "Enable separate key for corpse drop",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions
            },
            tryToLoadCorpseToBackpackFirst = {
                default = false,
                name = "Pack corpse to backpack if possible",
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
