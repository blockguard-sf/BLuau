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

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuauDirectory = ReplicatedStorage:WaitForChild("BLuau")
local LIB_DIRECTORY = BLuauDirectory:FindFirstChild("Lib")
if not LIB_DIRECTORY then
    error("[BLuau] ERROR: The directory 'Lib' was not found in ReplicatedStorage.")
end

-- Iterate over all children of "Lib" and load modules dynamically
for _, module in ipairs(LIB_DIRECTORY:GetChildren()) do
    if module:IsA("Folder") and module.__init ~= nil then
        local success, result = pcall(require, module.__init)
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

return BLuau