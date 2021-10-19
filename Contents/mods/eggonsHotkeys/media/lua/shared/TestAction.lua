require "TimedActions/ISBaseTimedAction"

TestAction = ISBaseTimedAction:derive("TestAction")

local function log(string)
    print("TestAction: " .. string)
end

function TestAction:isValid()
    print("isValid")
    return true
end

function TestAction:waitToStart()
    log("waitToStart")
    -- self.action:forceStop()
    -- self:forceStop()
    return false
end

function TestAction:update()
    self.updateNo = self.updateNo + 1
    print("update")
    -- self:forceStop()
end

function TestAction:start()
    print("start")
    -- self:forceStop()
end

function TestAction:perform()
    log("perform")
    self.performNo = self.performNo + 1
    print("Perform no: ", self.performNo)
    print("Updates no: ", self.updateNo)

    -- Remove Timed Action from stack
    ISBaseTimedAction.perform(self)
end
function TestAction:forceStop()
    log("Force stop " .. self.no)
    self.action:forceStop()
end

function TestAction:stop()
    log("stop " .. self.no)
    ISBaseTimedAction.stop(self)
end

function TestAction:new(character, no)
    log("new")

    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.stopOnWalk = true
    o.stopOnRun = true
    o.character = character
    o.maxTime = 5000
    o.performNo = 0
    o.updateNo = 0
    o.no = no
    return o
end
