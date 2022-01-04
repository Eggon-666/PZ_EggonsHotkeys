function EHK.CheckForWindow(worldobjects)
    for i = 0, worldobjects:size() - 1 do
        local window = worldobjects:get(i)
        -- for _, window in ipairs(worldobjects) do
        if instanceof(window, "IsoWindow") then
            if (window:IsOpen() or window:isSmashed()) and not window:isBarricaded() then
                print("Is window 1")
            end
        elseif instanceof(window, "IsoThumpable") and not window:isDoor() then
            if window:isWindow() and window:canClimbThrough(player) then
                print("Is window 2")
            elseif window:isHoppable() and window:canClimbOver(player) then
                print("Is window 3")
            end
        -- elseif instanceof(window, "IsoObject") and (window:isHoppable() or OutTheWindow.hasFence(window)) then
        -- print("Is window 4")
        end
    end
end

-- sq:getX(), sq:getY()
-- getSquare(x,y,z)
