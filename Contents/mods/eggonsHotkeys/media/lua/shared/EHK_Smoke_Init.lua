EHK = EHK or {}

EHK.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.Matches",
    [3] = "SM.Matches"
}

EHK.smokerIsPresent = false

EHK.cigarettes = {
    [1] = "Base.Cigarettes",
    [2] = "SM.SMCigarette",
    [3] = "SM.SMHomemadeCigarette",
    [4] = "SM.SMHomemadeCigarette2",
    [5] = "SM.SMCigaretteLight", -- sztuka
    [6] = "SM.SMPCigaretteMenthol", -- sztuka
    [7] = "SM.SMPCigaretteGold", -- sztuka
    [8] = "CigaretteMod.CigarettesOne"
}

EHK.cigarettesPacks = {
    ["SM.SMPack"] = "Take Cigarette from Pack",
    ["SM.SMPackLight"] = "Take Cigarette from Pack",
    ["SM.SMPackMenthol"] = "Take Cigarette from Pack",
    ["SM.SMPackGold"] = "Take Cigarette from Pack"
}

EHK.validRecipes = {
    ["Take Cigarette from Pack"] = true
    -- ["Open Packet"] = true
}
