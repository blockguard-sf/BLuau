--[[
    Entry point of the BLuau system.

    This module serves as the main inclusion point for BLuau, automatically loading all modules
    from the "Libraries" directory.

    Modules should be placed in ReplicatedStorage.BLuau.Libraries for better organization and
    automatic discovery.

    To use this system, scripts should simply:
        local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau").BLibraries)

    and then access module like:
        local logging = BLuau.logging
        logging.log("Hello from BLuau!", "INFO")

    Author: BlockGuard Software Foundation
    Version: 1.0.0
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau_Rojo = ReplicatedStorage:WaitForChild("BLuau_Rojo")
local LIBRARIES_DIRECTORY = BLuau_Rojo:FindFirstChild("Libraries")
if not LIBRARIES_DIRECTORY then
    error("[BLuauLoader] ERROR : The directory 'Libraries' was not found in ReplicatedStorage.")
end

local function __loadModule(moduleScript: Instance) : (boolean, any)
    return pcall(require, moduleScript)
end

local Loader = {}

for _, moduleScript in pairs(LIBRARIES_DIRECTORY:GetChildren()) do
    if moduleScript:IsA("Folder") and moduleScript:FindFirstChild("__init") or moduleScript:IsA("ModuleScript") then
        local success, result = __loadModule(if moduleScript:IsA("Folder") then moduleScript.__init else moduleScript)

        if success then
            Loader[moduleScript.Name] = result
        else
            warn(string.format("[BLuauLoader] WARNING: Failed to load module '%s'. Error: %s", moduleScript.Name, result))
        end
    end
end

return Loader