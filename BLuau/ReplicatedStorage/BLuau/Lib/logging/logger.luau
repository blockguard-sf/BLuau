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
    Module["__data"][level] = logEntry
end

--- Retrieves all log entries.
--- @return table The table containing all log entries.
function Module:GetLog()
    return Module["__data"]
end

return Module