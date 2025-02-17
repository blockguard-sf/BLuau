# profiler — Profiler Package for Luau

This module provides profiling operations for Luau, allowing you to measure execution times of code segments or functions. It is based on Lua 5.1 syntax and is designed to help developers identify performance bottlenecks by tracking the duration of operations.

> **Note:** To use this package, simply import it using `require(profiler)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Session Management](#session-management)
  - [Profiling Functions](#profiling-functions)
    - [start](#start)
    - [stop](#stop)
    - [measure](#measure)
    - [listSessions](#listsessions)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `profiler` module is designed to help you measure the performance of your code by:
- Recording the start time of operations or named sessions.
- Calculating the elapsed time when the session stops.
- Measuring the execution time of functions.
- Listing all active profiling sessions for debugging purposes.

## Usage

To use the profiler in your Luau code:

```lua
local Profiler = require(profiler)
```

Once imported, you can call the provided functions to start, stop, and measure the execution time of your code segments.

## Module Contents

### Session Management

- **`Module.sessions`**  
  A table that stores active profiling sessions. When you start a session with a label, its start time is stored here.

### Profiling Functions

#### start

- **`Module.start(label: unknown): number`**  
  Records the current time (using `os.clock`) to mark the start of a profiling session.
  
  - **Parameters:**
    - `label` (optional): If provided, the session is stored with this label in `Module.sessions`.
  
  - **Returns:**
    - The start time as a number.

#### stop

- **`Module.stop(labelOrStartTime): number`**  
  Ends a profiling session and returns the elapsed time.
  
  - **Parameters:**
    - `labelOrStartTime`: Can be either a string label (if you started a named session) or a numeric start time.
  
  - **Behavior:**
    - If a label is provided, the function retrieves the start time from `Module.sessions`, removes the session, and returns the elapsed time.
    - If a numeric start time is provided, it simply calculates the elapsed time.
  
  - **Returns:**
    - The elapsed time as a number.
  
  - **Errors:**
    - Throws an error if a label is provided but no session is found.
    - Throws an error if an invalid argument is provided.

#### measure

- **`Module.measure(func: function, ...: any): (number, ...nil)`**  
  Measures the execution time of a function.
  
  - **Parameters:**
    - `func`: The function to be measured.
    - Additional parameters to pass to `func`.
  
  - **Returns:**
    - The elapsed time (in seconds) as a number, followed by all results returned by `func`.
  
  - **Behavior:**
    - Validates that the first parameter is a function.
    - Uses `os.clock` to record the start and end times, then computes the elapsed time.
  
  - **Errors:**
    - Throws an error if the provided argument is not a function.

#### listSessions

- **`Module.listSessions(): ()`**  
  Prints all active profiling sessions and their start times to the console.
  
  - **Usage:**
    - Useful for debugging to see which profiling sessions are currently active.

## Example Usage

```lua
local Profiler = require(profiler)

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
```

## Error Handling

- The `stop` function will throw an error if:
  - A label is provided that does not exist in the active sessions.
  - An invalid argument (neither a string nor a number) is provided.
- The `measure` function will throw an error if the provided argument is not a function.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.