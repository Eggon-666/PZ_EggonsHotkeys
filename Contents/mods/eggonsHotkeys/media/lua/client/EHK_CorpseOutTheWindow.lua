local OutTheWindow
if getActivatedMods():contains("OutTheWindow") then
    OutTheWindow = require("OutTheWindow/OutTheWindow")
end

local function getFence(player, worldObjects)
    local output
    for i = 0, worldObjects:size() - 1 do
        local allegedFence = worldObjects:get(i)
        local type, fence = OutTheWindow.getThrowType(player, allegedFence)
        if type == OutTheWindow.throwTypeFence then
            output = fence
            break
        end
    end
    return output
end

local northernDirections = {
    [IsoDirections.N] = true,
    [IsoDirections.NE] = true,
    [IsoDirections.NW] = true
}

local function getWindow(player)
    local windowOrFenceCandidate
    local direction = player:getDir()
    local relevantDirections = EHK.getNeighbouringDirections(direction)
    local windowOrFenceType, windowOrFence
    for i, dir in ipairs(relevantDirections) do
        windowOrFenceCandidate = player:getContextDoorOrWindowOrWindowFrame(dir)
        if not windowOrFenceCandidate then
            local playerSquare = player:getSquare()
            local worldObjects
            if northernDirections[dir] then -- try current square first if facing north
                worldObjects = playerSquare:getObjects()
                windowOrFenceCandidate = getFence(player, worldObjects)
            end
            if not windowOrFenceCandidate then
                local searchedSquare = playerSquare:getTileInDirection(dir)
                worldObjects = searchedSquare:getObjects()
                windowOrFenceCandidate = getFence(player, worldObjects)
            end
        end
        if windowOrFenceCandidate then
            windowOrFenceType, windowOrFence = OutTheWindow.getThrowType(player, windowOrFenceCandidate)
        end
        if windowOrFence then
            break
        end
    end
    return windowOrFence
end

function EHK.ThrowOutTheWindowOrFence(player, corpse)
    if not OutTheWindow then
        return false
    end
    local windowOrFence = getWindow(player)
    if windowOrFence then
        OutTheWindow.onThrowCorpse({}, player, windowOrFence, corpse)
        return true
    end
    return false
end
