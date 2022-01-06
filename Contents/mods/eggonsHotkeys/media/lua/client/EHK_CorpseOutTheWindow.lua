function EHK.isWindow(allegedWindow, player)
    if instanceof(allegedWindow, "IsoWindow") then
        if (allegedWindow:IsOpen() or allegedWindow:isSmashed()) and not allegedWindow:isBarricaded() then
            -- print("Is window 1")
            return true
        end
    elseif instanceof(allegedWindow, "IsoThumpable") and not allegedWindow:isDoor() then
        if allegedWindow:isWindow() and allegedWindow:canClimbThrough(player) then
            -- print("Is window 2")
            return true
        elseif allegedWindow:isHoppable() and allegedWindow:canClimbOver(player) then
            -- print("Is window 3")
            return true
        end
    elseif instanceof(window, "IsoObject") and (window:isHoppable() or OutTheWindow.hasFence(window)) then
        -- print("Is window 4")
        return true
    end
    return false
end
-- function EHK.CheckForWindow(worldobjects)
--     local player = getPlayer()
--     for i = 0, worldobjects:size() - 1 do
--         local allegedWindow = worldobjects:get(i)
--         EHK.isWindow(allegedWindow, player)
--     end
-- end
