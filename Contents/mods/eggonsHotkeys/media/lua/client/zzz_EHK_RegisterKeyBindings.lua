EHK.keyConfigs = {
    pickup = {
        action = EHK.createFurnitureCursor,
        keyCode = 200
    },
    place = {
        action = EHK.createFurnitureCursor,
        keyCode = 208
    },
    rotate = {
        action = EHK.createFurnitureCursor,
        keyCode = 205
    },
    scrap = {
        action = EHK.createFurnitureCursor,
        keyCode = 211
    },
    smoke = {
        action = EHK.smoke,
        keyCode = 37
    },
    betaBlockers = {
        action = EHK.takeBetaBlockers,
        keyCode = 40
    },
    painKillers = {
        action = EHK.takePainKillers,
        keyCode = 43
    },
    sledgehammer = {
        action = EHK.equipSledgehammer,
        keyCode = 0
    },
    chopWithAxe = {
        action = EHK.equipAxe,
        keyCode = 0
    },
    umbrella = {
        action = EHK.equipUmbrella,
        keyCode = 0
    }
}

local mybind = {}
mybind.value = "[eggonsHotkeys]"
table.insert(keyBinding, mybind)

for keyVar, cfg in pairs(EHK.keyConfigs) do
    mybind = {}
    mybind.value = keyVar
    mybind.key = cfg.keyCode
    table.insert(keyBinding, mybind)
end

for keyVar, cfg in pairs(EHK_Plugin.keyConfigs) do
    if not EHK.keyConfigs[keyVar] then
        mybind = {}
        mybind.value = keyVar
        mybind.key = cfg.keyCode
        table.insert(keyBinding, mybind)
    end
end
