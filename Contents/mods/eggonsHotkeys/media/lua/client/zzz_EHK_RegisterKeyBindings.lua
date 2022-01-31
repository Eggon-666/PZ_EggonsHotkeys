EHK.keyConfigs = {
    pickup = {
        isHotAction = false,
        isFlexKey = true,
        displayName = "Pick up furniture",
        action = EHK.createFurnitureCursor,
        keyCode = 200
    },
    place = {
        isHotAction = false,
        isFlexKey = true,
        displayName = "Place furniture",
        action = EHK.createFurnitureCursor,
        keyCode = 208
    },
    rotate = {
        isHotAction = false,
        isFlexKey = false,
        action = EHK.createFurnitureCursor,
        keyCode = 205
    },
    scrap = {
        isHotAction = false,
        isFlexKey = true,
        displayName = "Scrap furniture",
        action = EHK.createFurnitureCursor,
        keyCode = 211
    },
    smoke = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Smoke",
        action = EHK.smoke,
        keyCode = 37
    },
    betaBlockers = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Take Beta Blockers",
        action = EHK.takeBetaBlockers,
        keyCode = 40
    },
    painKillers = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Take Pain killers",
        action = EHK.takePainKillers,
        keyCode = 43
    },
    vitamins = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Take Vitamins (1 pill)",
        action = EHK.takeVitamins,
        keyCode = 0
    },
    sledgehammer = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Demolish (& equip sledgehammer)",
        action = EHK.equipSledgehammer,
        keyCode = 0
    },
    chopWithAxe = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Chop trees (& equip axe)",
        action = EHK.equipAxe,
        keyCode = 0
    },
    umbrella = {
        isHotAction = true,
        isFlexKey = true,
        displayName = "Umbrella - equip / unequip",
        action = EHK.equipUmbrella,
        keyCode = 0
    },
    corpseDisposal = {
        isHotAction = false,
        isFlexKey = true,
        displayName = "Corpse disposal",
        action = EHK.corpseDisposal,
        keyCode = 0
    },
    corpsePickup = {
        isHotAction = false,
        isFlexKey = false,
        displayName = "Corpse pickup",
        action = EHK.corpseDisposal,
        keyCode = 0
    },
    equipMolotov = {
        isHotAction = true,
        isFlexKey = true,
        action = EHK.equipMolotov,
        displayName = "Equip molotov",
        keyCode = 0
    },
    extinguishFire = {
        isHotAction = true,
        isFlexKey = true,
        action = EHK.equipExtinguisher,
        displayName = "Extinguish fire",
        keyCode = 0
    },
    sitOnTheGround = {
        isHotAction = false,
        isFlexKey = true,
        action = EHK.sitOnTheGround,
        displayName = "Sit on the ground",
        keyCode = 0
    },
    flexKey = {
        isHotAction = false,
        isFlexKey = false,
        action = EHK.triggerFlexKey,
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
