EHK = EHK or {}

EHK.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.Matches"
}

EHK.smokerIsPresent = false

EHK.cigarettes = {
    [1] = "Base.Cigarettes"
}

EHK.smokerCigarettes = {
    [2] = "SM.SMCigarette",
    [3] = "SM.SMHomemadeCigarette",
    [4] = "SM.SMHomemadeCigarette2",
    [5] = "SM.SMCigaretteLight", -- sztuka
    [6] = "SM.SMPCigaretteMenthol", -- sztuka
    [7] = "SM.SMPCigaretteGold" -- sztuka
}
EHK.smokerCigarettesPacks = {
    [1] = "SM.SMPack",
    [2] = "SM.SMPackLight",
    [3] = "SM.SMPackMenthol",
    [4] = "SM.SMPackGold"
}
-- Smoker mod existence verification
local smokerMatches = getScriptManager():getItem("SM.Matches")
if smokerMatches and type(smokerMatches) ~= "string" then
    -- print("Smoker mod detected")
    EHK.fireSources[3] = "SM.Matches"
    for i, fullType in pairs(EHK.smokerCigarettes) do
        table.insert(EHK.cigarettes, i, fullType)
    end
    EHK.smokerIsPresent = true
else
    -- print("Smoker mod NOT detected")
end
