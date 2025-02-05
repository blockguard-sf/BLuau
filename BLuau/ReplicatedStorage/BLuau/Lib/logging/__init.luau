--[[
Logging package for Luau. Based on Luau syntax in Lua 5.1
and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'import logging' and log away!
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

    return false
end

--- Processes a log entry with the given source and message.
--- Constructs the log entry and returns it, or an error message if processing fails.
--- @param source string The source of the log entry.
--- @param message string The message of the log entry.
--- @return string The formatted log entry or an error message.
local function __processLog(source, message)
    return handlers.__construct(source, message) or "Log processing failed"
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
    
    if self.level then
        self.logEntry = __processLog(self.source, message)
        if self.level >= handlers:GetLevel("WARN") then
            warn(self.logEntry)
        else
            print(self.logEntry)
        end
    end

    logger:SetLog(self.level, self.logEntry)
    return self
end

--- Adds a new log level with the specified priority.
--- Automatically adjusts priority if a conflict exists and autoCorrection is enabled.
--- @param level string The name of the new log level.
--- @param priority number The priority value of the new log level.
--- @param autoCorrect boolean Whether to enable auto-correction of conflicting priorities.
--- @return boolean success True if the log level was added successfully.
function Module.addLevel(level: string, priority: string, autoCorrect: boolean)
    return handlers.add(level, priority, autoCorrect)
end

--- Retrieves all log entries from the logger.
--- @return table The table containing all log entries.
function Module:GetLog()
    return logger:GetLog()
end

return Module