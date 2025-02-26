--[[
Additional handlers for the logging package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(logging.handlers)' and log away!
--]]

local Handlers = {}
Handlers.__internal = Handlers
Handlers.__levels = {
	["DEBUG"] = 0,
	["INFO"] = 1,
	["WARN"] = 2,
	["ERROR"] = 3,
}
Handlers.__internal = {
	timestamp = os.date,
	formatString = string.format,
}

local function __isValidLevel(levelName: string, levelIndex: number, autoCorrect: boolean): table | boolean
	if type(levelName) ~= "string" or type(levelIndex) ~= "number" then
		warn("[LOGGING] - Invalid input type for level or index.")
		return false
	end

	local ValidatedArguments: { Index: number, Level: string } = {}
	for name: string, index: any in pairs(Handlers.__levels) do
		if name == levelName then
			warn("[LOGGING] - Duplicate log level name: " .. levelName)
			return false
		end

		if index == levelIndex then
			if autoCorrect then
				levelIndex = #Handlers.__levels + 1 -- Take the existing level number and add 1
			else
				warn("[LOGGING] - Duplicate index detected: " .. levelIndex)
				return false
			end
		end
	end
	ValidatedArguments["Level"] = levelName
	ValidatedArguments["Index"] = levelIndex
	return ValidatedArguments
end

local function __timestamp(): string
	return Handlers.__internal.timestamp("%Y-%m-%d %H:%M:%S")
end

--- Construct a new log entry with the given source and message.
--- Include a timestamp in the predefined format.
function Handlers:__construct(source: string, message: string): string & table
	local instance = setmetatable({
		timestamp = __timestamp(),
	}, Handlers)

	if type(source) ~= "string" or type(message) ~= "string" then
		warn("[LOGGING] - Invalid input types for source or message.")
		return "Invalid log construction", nil
	end

	return Handlers.__internal.formatString("[%s] [%s] - %s", instance.timestamp, source, message), instance
end

--- Construct a new log entry with the given source, message, priority level, and initial script information.
--- Includes a timestamp in predefined format.
function Handlers:__constructError(source: string, message: string, levelName: string, callerInfo): (string, nil)
	local instance = setmetatable({
		timestamp = __timestamp(),
		source = if source == "SERVER" then "Script" else "LocalScript",
		callerInfo = callerInfo
	}, Handlers)

	if type(source) ~= "string" or type(message) ~= "string" then
		warn("[LOGGING] - Invalid input types for source or message or levelName.")
		return "Invalid log construction", nil
	end
	return Handlers.__internal.formatString("[%s] %s - %s: \"%s.luau\", Line: %s\n		Message: \"%s\"\n		Stack Trace: %s", string.upper(levelName), instance.timestamp, instance.source, instance.callerInfo.scriptObject, instance.callerInfo.lineNumber, message, instance.callerInfo.rawTrace), instance
end

--- Adds a new log level with the specified index.
--- Automatically adjust index if a conflict exists and auto-correction is enabled.
function Handlers:__addLevel(level: string, index: number, autoCorrect: boolean?): boolean & table
	local instance = setmetatable({
		level = string.upper(level),
		autoCorrect = autoCorrect or false,
	}, Handlers)

	instance.validLevel = __isValidLevel(instance.level, index, instance.autoCorrect)
	if instance.validLevel then
		instance.level = instance.validLevel["Level"]
		instance.index = instance.validLevel["Index"]

		Handlers.__levels[instance.level] = instance.index
		return true, instance
	end
	warn("[LOGGING] - Failed to add new log level: " .. instance.level)
	return false, instance
end

--- Retrieves the priority of the specified log level.
function Handlers:GetLevel(levelName: string?): number | table
	if type(levelName) == "string" and Handlers.__levels[string.upper(levelName)] ~= nil then
		return Handlers.__levels[levelName]
	end
	return Handlers.__levels
end

return Handlers
