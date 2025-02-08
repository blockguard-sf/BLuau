--[[
    logger.luau
    Async file for the client and server side "logging" package.
    This file contains a simple data management system.
--]]

local Module = {}
Module.__index = Module
Module["__data"] = {}

--- Sets a log entry for the specified log level.
--- @param level string The log level for the entry.
--- @param logEntry string The log entry to set.
function Module:SetLog(level: string, logEntry: string)
    if type(level) ~= "string" or type(logEntry) ~= "string" then
        warn("[LOGGING] - Invalid input types for level or logEntry.")
        return false
    end

    Module["__data"][level] = logEntry
    return true
end

--- Retrieves all log entries.
--- @return table The table containing all log entries.
function Module:GetLog()
    return Module["__data"]
end

--- Clears all log entries.
--- This function can be used to reset the logger data.
--- @return boolean success True if the log entries were cleared successfully.
function Module:ClearLog()
    Module["__data"] = {}
    return true
end

--- Example usage:
--- local logger = require(logger)
--- logger:SetLog("INFO", "This is an info log entry.")
--- print(logger:GetLog()) -- Output: { ["INFO"] = "This is an info log entry." }
--- logger:ClearLog()
--- print(logger:GetLog()) -- Output: {}

return Module