--[[
    Entry point of the BLuau system.

    This module serves as the main inclusion point for BLuau, automatically loading all modules
    script for BLuau.

    To use BLuau, should simply:
        local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibraries)

    and then access module like:
        local logging = BLuau.logging
        logging.log("Hello from BLuau!", "INFO")

    Author: BlockGuard Software Foundation
    Version: 1.0.0
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau_Rojo = ReplicatedStorage:WaitForChild("BLuau_Rojo")

local LOADER_DIRECTORY = BLuau_Rojo:WaitForChild("Core"):FindFirstChild("System")

local Loader = require(LOADER_DIRECTORY.Loader)

local BLibraries = {}
BLibraries.__index = BLibraries

--- Retrieving information from the Module Loader to facilitate their naming.
for moduleName, value in pairs(Loader) do
    BLibraries[moduleName] = value
end

return BLibraries