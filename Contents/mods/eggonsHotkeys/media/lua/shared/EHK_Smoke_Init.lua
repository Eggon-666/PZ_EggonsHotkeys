EHK = EHK or {}

EHK.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.Matches"
}

EHK.cigarettes = {
    [1] = "Base.Cigarettes"
}

local smokerCigarettes = {
    [2] = "SM.SMCigarette",
    [3] = "SMHomemadeCigarette",
    [4] = "SMHomemadeCigarette2",
    [5] = "SMPack", -- czy to paczka czy tylko pojemnik?
    [6] = "SMCigaretteLight", -- sztuka
    [7] = "SMPackLight", -- czy to paczka czy tylko pojemnik?
    [8] = "SMPCigaretteMenthol", -- sztuka
    [9] = "SMPackMenthol", -- czy to paczka czy tylko pojemnik?
    [10] = "SMPCigaretteGold", -- sztuka
    [11] = "SMPackGold" -- czy to paczka czy tylko pojemnik?
}
-- Smoker mod existence verification
local smokerMatches = getScriptManager():getItem("SM.Matches")

if smokerMatches then
    EHK.fireSources[3] = "SM.Matches"
else
end
