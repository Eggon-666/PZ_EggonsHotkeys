EHK = {keyConfigs = {}}

EHK_Plugin = {keyConfigs = {}}

function EHK_Plugin:AddConfigs(keyConfigs)
    for keyVar, cfg in pairs(keyConfigs) do
        if self.keyConfigs[keyVar] or EHK.keyConfigs[keyVar] then
            print("ERROR: Tried to register existing key binding under existing name.")
        else
            self.keyConfigs[keyVar] = cfg
        end
    end
end
