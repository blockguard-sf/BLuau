--[[
    Entry point of the BLuau system.

    This module serves as the main inclusion point for BLuau, automatically loading all modules
    script for BLuau.

    To use BLuau, should simply:
        local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibrary)

    and then access module like:
        local logging = BLuau.logging
        logging.log("Hello from BLuau!", "INFO")

    Author: BlockGuard Software Foundation
    Version: 1.1.0
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau_Rojo: Folder = ReplicatedStorage:WaitForChild("BLuau_Rojo")

local LOADER_DIRECTORY: Folder = BLuau_Rojo:WaitForChild("Core"):FindFirstChild("System")

local Loader = require(LOADER_DIRECTORY.Loader)

local BLibrary = {}
BLibrary.__index = BLibrary

--- Retrieving information from the Module Loader to facilitate their naming.
for moduleName: unknown, value: nil in pairs(Loader) do
	BLibrary[moduleName] = value
end

return BLibrary
