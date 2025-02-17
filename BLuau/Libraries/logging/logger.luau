--[[
Additional logger for the logging package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(logging.logger)' and log away!
--]]

local Logger = {}
Logger.__index = Logger
Logger.__data = {}

--- Sets a log entry for the specified log level.
function Logger.setLog(levelName: string, logEntry: string): boolean
	if type(levelName) ~= "string" or type(logEntry) ~= "string" then
		warn("[LOGGING] - Invalid input types for levelName or logEntry")
		return false
	end

	table.insert(Logger.__data, {
		["level"] = levelName,
		["message"] = logEntry,
	})
	return true
end

--- Retrieves all log entries.
function Logger.clear(): boolean
	local success: boolean, errMsg: nil = pcall(function(): ()
		table.clear(Logger.__data)
	end)

	if not success then
		warn("[LOGGING] - An error occurred while deleting logs: " .. errMsg)
		return false
	end
	return true
end

return Logger
