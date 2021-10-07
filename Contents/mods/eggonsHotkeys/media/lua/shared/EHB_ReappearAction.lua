require "TimedActions/ISBaseTimedAction"

TestAction = ISBaseTimedAction:derive("ReappearItems")

function ReappearItems:isValid()
    -- log("isValid")
    return true
end

function ReappearItems:perform()
    for i, item in pairs(self.itemsToReappear) do
        self.container:addItem(item)
    end
    -- Remove Timed Action from stack
    ISBaseTimedAction.perform(self)
end

function ReappearItems:new(character, itemsToReappear, container)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.stopOnWalk = true
    o.stopOnRun = true
    o.stopOnAim = true
    o.character = character
    o.container = container
    o.itemsToReappear = itemsToReappear
    o.maxTime = -1
    return o
end
