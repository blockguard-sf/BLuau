--[[
Profiler package for Luau. Based on Lua syntax version 5.1.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(profiler)' and use profiling operations!
--]]

local Module = {}
Module.__index = Module

-- Stores active profiling sessions
Module.sessions = {}

-- Starts profiling by recording the current time
function Module.start(label)
    local startTime = os.clock()
    if label then
        Module.sessions[label] = startTime
    end
    return startTime
end

-- Ends profiling and returns the elapsed time
function Module.stop(labelOrStartTime)
    local endTime = os.clock()
    if type(labelOrStartTime) == "string" then
        local startTime = Module.sessions[labelOrStartTime]
        if not startTime then
            error("Module.stop: No session found for label " .. labelOrStartTime)
        end
        Module.sessions[labelOrStartTime] = nil
        return endTime - startTime
    elseif type(labelOrStartTime) == "number" then
        return endTime - labelOrStartTime
    else
        error("Module.stop: Invalid start time or label")
    end
end

-- Measures the execution time of a function
function Module.measure(func, ...)
    if type(func) ~= "function" then
        error("Module.measure: Expected a function")
    end
    local startTime = os.clock()
    local results = table.pack(func(...))
    local elapsedTime = os.clock() - startTime
    return elapsedTime, table.unpack(results, 1, results.n)
end

-- Prints all active sessions (for debugging purposes)
function Module.listSessions()
    for label, startTime in pairs(Module.sessions) do
        print("Active session:", label, "Started at:", startTime)
    end
end

return Module

--[[
Example Usage:

local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").Core.System.Loader)

local Profiler = BLuau.profiler

-- Simple profiling
local startTime = Profiler.start()
for i = 1, 1e6 do end -- Simulating workload
local elapsedTime = Profiler.stop(startTime)
print("Execution time:", elapsedTime)

-- Named session profiling
Profiler.start("heavyTask")
for i = 1, 1e6 do end
local namedElapsedTime = Profiler.stop("heavyTask")
print("Heavy task execution time:", namedElapsedTime)

-- Function measurement
local function compute(a, b)
    for i = 1, 1e5 do end -- Simulating workload
    return a + b
end
local timeTaken, result = Profiler.measure(compute, 5, 10)
print("Function execution time:", timeTaken, "Result:", result)

-- Listing active sessions
Profiler.start("task1")
Profiler.start("task2")
Profiler.listSessions()
Profiler.stop("task1")
Profiler.stop("task2")

-- Error handling test
pcall(function()
    Profiler.stop("nonexistentSession")
end)
--]]
