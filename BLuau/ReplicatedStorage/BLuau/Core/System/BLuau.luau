--[[
    Entry point of the BLuau system.

    This module serves as the main inclusion point for BLuau,
    automatically loading all modules from the "Lib" directory.

    Modules should be placed in ReplicatedStorage.BLuau.Lib for better
    organization and automatic discovery.

    To use this system, scripts should simply:
        local BLuau = require(game.ReplicatedStorage.BLuau.Include.BLuau)
    
    and then access module like:
        local logging = BLuau.logging
        logging.log("Hello from BLuau!", "INFO")

    Author: BlockGuard Software Foundation
    Version: 1.0.0
--]]

-- Prevent multiple inclusions
if _G.__BLUAU_LOADED then
    return _G.__BLUAU_INSTANCE
end

local BLuau = {}

-- Define the base path for modules (for explicit loading if needed)
local BASE_PATH = "BLuau.Lib."

-- Defines priority modules
local PRIORITY_MODULES = {"logging"}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuauDirectory = ReplicatedStorage:WaitForChild("BLuau")
local LIBRARIES_DIRECTORY = BLuauDirectory:WaitForChild("Modules"):FindFirstChild("Libraries")
if not LIBRARIES_DIRECTORY then
    error("[BLuau] ERROR: The directory 'Lib' was not found in ReplicatedStorage.")
end

--- Checks if the given module is a priority module.
--- @param module Instance The module to check.
--- @return boolean True if the module is a priority module, false otherwise.
local function __checkPriorityModule(module: Instance)
    for _, moduleName in pairs(PRIORITY_MODULES) do
        if moduleName == module.Name then
            return true
        end
    end
    return false
end

--- Loads the specified module using pcall to handle errors.
--- @param module Instance The module to load.
--- @return boolean, any True and the module if successful, false and the error message if failed.
local function __loadModule(module: Instance)
    return pcall(require, module)
end

--- Loads priority modules and adds them to the BLuau table.
for _, module_name in pairs(PRIORITY_MODULES) do
    local success, result = __loadModule(if LIBRARIES_DIRECTORY[module_name]:IsA("Folder") then LIBRARIES_DIRECTORY[module_name].__init else LIBRARIES_DIRECTORY[module_name])
    if success then
        BLuau[module_name] = result
    else
        warn(string.format("[BLuau] WARNING: Failed to load priority module '%s'. Error: %s", module_name, result))
    end
end

-- Iterate over all children of "Lib" and load modules dynamically
for _, module in ipairs(LIBRARIES_DIRECTORY:GetChildren()) do
    local priorityModule = __checkPriorityModule(module)
    if not priorityModule then
        local success, result = __loadModule(if module:IsA("Folder") then module.__init else module)
        if success then
            BLuau[module.Name] = result
        else
            warn(string.format("[BLuau] WARNING: Failed to load module '%s'. Error: %s", module.Name, result))
        end
    end
end

--[[
    Global Singleton:
    - Ensures that BLuau is loaded only once.
    - Stores the instance in _G to prevent redundant requires.
--]]
_G.__BLUAU_LOADED = true
_G.__BLUAU_INSTANCE = BLuau

print(BLuau)

return BLuau