--[[
    handlers.luau
    Utility file for the "logging" package.
    This file constains a log level management and a formatting moduLe.
--]]

local __levels = {
    ["DEBUG"] = 0;
    ["INFO"] = 1;
    ["WARN"] = 2;
    ["ERROR"] = 3
}

local __internal = {
    timestamp = os.date,
    formatString = string.format
}

local Module = {}
Module.__index = Module

--- Validates the log level and priority, optionally auto-correcting conflicts.
--- Checks for duplicate log level names and priorities, and adjusts the priority if auto-correction is enabled.
--- @param level string The name of the log level to validate.
--- @param priority number The priority value of the log level to validate.
--- @param autoCorrect boolean Whether to enable auto-correction of conflicting priorities.
--- @return table|boolean validatedArguments A table containing the validated level and priority, or false if validation fails.
local function __validLevel(level, priority, autoCorrect)
    if type(level) ~= "string" or type(priority) ~= "number" then
        warn("[LOGGING] - Invalid input types for level or priority.")
        return false
    end

    local validatedArguments = {}
    for name, index in pairs(__levels) do
        if name == level then
            warn("[LOGGING] - Duplicate log level name: " .. level)
            return false
        end

        if index == priority then
            if autoCorrect then
                priority = #__levels + 1
                validatedArguments["Priority"] = priority
            else
                warn("[LOGGING] - Duplicate priority detected: " .. priority)
                return false
            end
        end
    end
    validatedArguments["Level"] = level
    if not validatedArguments["Priority"] then
        validatedArguments["Priority"] = priority
    end
    return validatedArguments
end

--- Retrieves the current timestamp in a predefined format.
--- @return string The formatted current timestamp.
local function __timestamp()
    return __internal.timestamp("%Y-%m-%d %H:%M:%S")
end

--- Constructs a new log entry with the given source and message.
--- Includes a timestamp in the predefined format.
--- @param source string The source of the log entry.
--- @param message string The message of the log entry.
--- @return string formattedLog The formatted log entry string.
--- @return table self The constructed log entry object.
function Module.__construct(source: string, message: string)
    local self = setmetatable({
        timestamp = __timestamp()
    }, Module)

    if type(source) ~= "string" or type(message) ~= "string" then
        warn("[LOGGING] - Invalid input types for source or message.")
        return "Invalid log construction", nil
    end

    return __internal.formatString("[%s] [%s] - %s", self.timestamp, source, message), self
end

--- Adds a new log level with the specified priority.
--- Automatically adjusts priority if a conflict exists and autoCorrection is enabled.
--- @param level string The name of the new log level.
--- @param priority number The priority value of the new log level.
--- @param autoCorrect boolean Whether to enable auto-correction of conflicting priorities.
--- @return boolean success True if the log level was added successfully.
function Module.add(level: string, priority: number, autoCorrect: boolean?)
    local self = setmetatable({
        level = string.upper(level);
        priority = priority;
        autoCorrect = autoCorrect or false
    }, Module)

    self.validationLevel = __validLevel(self.level, self.priority, self.autoCorrect)
    if self.validationLevel then
        self.priority = self.validationLevel["Priority"]
        self.level = self.validationLevel["Level"]

        __levels[self.level] = self.priority
        return true, self
    end
    warn("[LOGGING] - Failed to add log level: " .. self.level)
    return false, self
end

--- Retrieves the priority of the specified log level.
--- If the level is not found, it returns a warning and the complete list of levels.
--- @param level string The name of the log level to retrieve.
--- @return number|table The priority of the specified log level or the complete list of levels if no specific level is provided.
function Module:GetLevel(level)
    if level ~= nil then
        level = string.upper(level)
        if __levels[level] ~= nil then
            return __levels[level]
        else
            warn("[LOGGING] - Invalid level: " .. level)
        end
    end
    return __levels
end

return Module