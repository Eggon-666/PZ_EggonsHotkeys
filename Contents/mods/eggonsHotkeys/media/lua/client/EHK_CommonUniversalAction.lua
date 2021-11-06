require "TimedActions/ISBaseTimedAction"

local UniversalAction = ISBaseTimedAction:derive("UniversalAction")

function UniversalAction:isValid()
    return true
end

function UniversalAction:waitToStart()
    return false
end

function UniversalAction:perform()
    self:callback(self)
    -- Remove Timed Action from stack
    ISBaseTimedAction.perform(self)
end

function UniversalAction:new(character, item, action, maxTime)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.__call = self
    o.stopOnWalk = true
    o.stopOnRun = true
    o.callback = action
    o.character = character
    o.maxTime = maxTime or 0
    o.item = item
    return o
end

EHK.UniversalAction = UniversalAction

print("EHK.UniversalAction ", EHK.UniversalAction)
