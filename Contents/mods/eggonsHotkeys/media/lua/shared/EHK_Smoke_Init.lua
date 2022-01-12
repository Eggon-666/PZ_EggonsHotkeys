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
    [8] = "CigaretteMod.CigarettesOne",
    [9] = "Greenfire.GFCigarette"
}

EHK.cigarettesPacks = {
    [1] = "SM.SMPack",
    [2] = "SM.SMPackLight",
    [3] = "SM.SMPackMenthol",
    [4] = "SM.SMPackGold",
    [5] = "Greenfire.GFCigarettes", -- just to trigger prompt to unpack cigs for Greenfire mod
    [6] = "Base.Cigarettes" -- just to trigger prompt to unpack cigs for Carton mod
}

EHK.validRecipes = {
    ["Take Cigarette from Pack"] = true
    -- ["Open Packet"] = true
}
