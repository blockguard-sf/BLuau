--[[
Logging package for Luau. Based on Luau syntax in Lua 5.1
and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(logging.__init)' and log away!
--]]

--[[
    __init.luau
    Main file of the "logging" package.
    This file allows the game to interact with the package in a simple and
    secure way.
--]]

local RunService = game:GetService("RunService")

local Package = script.Parent
local handlers = require(Package:FindFirstChild("handlers"))
local logger = require(Package:FindFirstChild("logger"))

local Module = {}
Module.__index = Module
Module.__threshold = handlers:GetLevel().INFO
Module.__logger = true

--- Determines the current execution side (client or server).
--- @return string side The current execution side, either "CLIENT" or "SERVER".
local function __recoverSide()
    local clientSide = RunService:IsClient()
    return if clientSide then "CLIENT" else "SERVER"
end

--- Checks if the provided log level is valid.
--- @param level string The name of the log level to check.
--- @return number|boolean The priority of the log level if valid, or false if invalid.
local function __isValidLevel(level: string)
    local checkLevel = handlers:GetLevel(level)
    if typeof(checkLevel) == "number" then
        return checkLevel
    end

    warn("[LOGGING] - Invalid log level: " .. level)
    return false
end

--- Sets the logging threshold to the specified log level.
--- @param level string The log level to set as the threshold.
local function __setThreshold(level: string)
    if __isValidLevel(level) then
        Module.__threshold = handlers:GetLevel(level)
    else
        warn("[LOGGING] - Invalid log level for threshold: " .. level)
    end
end

--- Processes a log entry with the given source and message.
--- Constructs the log entry and returns it, or an error message if processing fails.
--- @param source string The source of the log entry.
--- @param message string The message of the log entry.
--- @return string The formatted log entry or an error message.
local function __processLog(source: string, message: string)
    local logEntrty, _ = handlers.__construct(source, message)
    return logEntrty or "Log processing failed"
end

--- Logs a message with the specified log level.
--- Determines the source (client or server) and validates the log level.
--- Processes the log entry and prints or warns based on the log level.
--- @param message string The message to log.
--- @param level string The log level for the message.
--- @return table self The log entry object.
function Module.log(message: string, level: string)
    local self = setmetatable({
        source = __recoverSide();
        level = __isValidLevel(level)
    }, Module)
    
    if self.level and self.level >= Module.__threshold then
        self.logEntry = __processLog(self.source, message)
        if self.level >= handlers:GetLevel("WARN") then
            warn(self.logEntry)
        else
            print(self.logEntry)
        end

        if Module.__logger then
            logger:SetLog(level, self.logEntry)
        end
    end
    return self
end

--- Configures the logging module with the specified logger and log level.
--- @param logger boolean? Whether to enable or disable the logger.
--- @param level string? The log level to set as the threshold.
--- @return table|boolean The module instance if successful, or false if invalid values are provided.
function Module.config(logger: boolean?, level: string?)
    local self = setmetatable({
        logger = if logger ~= nil then logger else Module.__logger;
        level = if level ~= nil then level else Module.__threshold
    }, Module)
    
    if not __isValidLevel(self.level) or type(logger) ~= "boolean" then
        warn("[LOGGING] - Invalid configuration values.")
        return false
    end

    Module.__logger = self.logger
    __setThreshold(level)

    return self
end

--- Adds a new log level with the specified priority.
--- Automatically adjusts priority if a conflict exists and autoCorrection is enabled.
--- @param level string The name of the new log level.
--- @param priority number The priority value of the new log level.
--- @param autoCorrect boolean Whether to enable auto-correction of conflicting priorities.
--- @return boolean success True if the log level was added successfully.
function Module.addLevel(level: string, priority: string, autoCorrect: boolean?)
    local success, result = handlers.add(level, priority, autoCorrect)
    if not success then
        warn("[LOGGING] - Failed to add log level: " .. result)
    end
    return result
end

--- Retrieves all log entries from the logger.
--- @return table The table containing all log entries.
function Module:GetLog()
    return logger:GetLog()
end

--- Clears all log entries from the logger.
--- @return boolean True if the log was cleared successfully.
function Module:ClearLog()
    return logger:ClearLog()
end

return Module