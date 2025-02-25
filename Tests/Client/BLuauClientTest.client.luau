local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibrary)

local Profiler = BLuau.profiler

-- Simple profiling
local startTime = Profiler.start()
for i = 1, 1e6 do
    local _ = i
end -- Simulating workload
local elapsedTime = Profiler.stop(startTime)
print("Execution time:", elapsedTime)

-- Named session profiling
Profiler.start("heavyTask")
for i = 1, 1e6 do
    local _ = i
end
local namedElapsedTime = Profiler.stop("heavyTask")
print("Heavy task execution time:", namedElapsedTime)

-- Function measurement
local function compute(a, b)
    for i = 1, 1e5 do
        local _ = i * 2 -- Simulating workload
    end
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