--[[
Logging package for Luau. Based on Lua syntax version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(logging.__init)' and log away!
--]]

local PACKAGE_DIRECTORY: Folder = script.Parent
local Handlers = require(PACKAGE_DIRECTORY:FindFirstChild("handlers"))
local Logger = require(PACKAGE_DIRECTORY:FindFirstChild("logger"))

--- Determines the current execution side (client or server).
local RunService = game:GetService("RunService")
local function __recoverSide(): string
	local server: boolean = RunService:IsServer()
	return if server then string.upper("server") else string.upper("client")
end

local function __isValidLevel(levelName: string): number | boolean
	local validLevel = Handlers:GetLevel(levelName)
	if type(validLevel) == "number" then
		return validLevel
	end

	warn(`[LOGGING] - Invalid log level: {levelName}`)
	return false
end

--- Processes a log entry with the given source and message.
--- Constructs the log entry and returns it, or an error message if processing fails.
local function __processLog(source: string, message: string, levelName: string?, callerInfo: table?): string
    local logEntry = if levelName ~= nil and callerInfo ~= nil then Handlers:__constructError(source, message, levelName, callerInfo) else Handlers:__construct(source, message)
    return logEntry or "Log processing failed."
end

local Module = {}
Module.__index = Module
Module.__levels = Handlers.__levels
Module.__threshold = Handlers:GetLevel("INFO")
Module.__logger = true

local function __getLevelName(levelIndex: string): string | boolean
	for name, index in Handlers:GetLevel() do
		if index == levelIndex then
			return name
		end
	end
	return false
end

--- Configures the logging module with the specified logger and log level.
function Module.config(logger: boolean?, levelName: string?): table | boolean
	local self = setmetatable({
		logger = if type(logger) == "boolean" then logger else Module.__logger,
		levelName = levelName or __getLevelName(Module.__threshold),
	}, Module)

	if not __isValidLevel(self.levelName) then
		warn("[LOGGING] - Invalid configuration values.")
		return false
	end

	Module.__logger = self.logger
	Module.__threshold = Handlers:GetLevel(self.levelName)
	return self
end

--- Logs a message with the specified log level.
--- Determines the source (client or server) and validates the log level.
--- Processes the log entry and prints or warns based on the log level.
function Module.log(message: string, levelName: string): table
	local self = setmetatable({
		source = __recoverSide(),
		levelIndex = __isValidLevel(levelName)
	}, Module)

	if self.levelIndex and self.levelIndex >= Module.__threshold then
		local callerInfo: { lineNumber: unknown, scriptObject: unknown } = {
			scriptObject = debug.info(2, "s"),
			lineNumber = debug.info(2, "l"),
			rawTrace = debug.traceback("", 2)
		}
		self.logEntry = if levelName == "ERROR" then __processLog(self.source, message, levelName, callerInfo) else __processLog(self.source, message)
		if self.logEntry then
			if self.levelIndex == Handlers:GetLevel("WARN") then
				warn(self.logEntry)
			else
				print(self.logEntry)
			end
		end
		if Module.__logger then
			Logger:SetLog(levelName, self.logEntry)
		end
	end
	return self
end

--- Adds a new log level with the specified index.
--- Automatically adjusts priority if a conflict exists and autoCorrect is enabled.
function Module:__addLevel(level: string, index: number, autoCorrect: boolean?): boolean
	local success, result: nil = Handlers:__addLevel(level, index, autoCorrect)
	if not success then
		warn("[LOGGING] - Failed to add log level: " .. result)
	end
	return result
end

function Module:GetLog(): {nil}
	return Logger.__data
end

function Module:Clear(): ()
	Logger.clear()
end

return Module
