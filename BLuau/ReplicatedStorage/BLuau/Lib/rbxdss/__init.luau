--[[
RbxDSS package for Luau. Based on Luau syntax in Lua 5.1
and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(rbxdss.__init)' and log away!
--]]

--[[
    __init.luau
    Main file of the "rbxdss" package.
    This file allows the game to interact with the package in a simple and
    secure way.
--]]

local Package = script.Parent
local recovery = require(Package:FindFirstChild("recovery"))
local backup = require(Package:FindFirstChild("backup"))

local Module = {}
Module.__index = Module

--- Retrieves data asynchronously for a specific player and data store.
--- @param player Player The player for whom to retrieve data.
--- @param dataStore string The name of the data store to retrieve data from.
--- @return any The result of the asynchronous recovery operation.
function Module:GetAsync(player: Player, dataStore: string)
    return recovery:GetAsync(player, dataStore)
end

--- Saves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
--- @param player Player The player for whom to save data.
--- @param dataStore string The name of the data store to save data to.
--- @param objectValue any The data to save.
--- @return table The module instance.
function Module:SetAsync(player: Player, dataStore: string, objectValue)
    return backup:SetAsync(player, dataStore, objectValue)
end

return Module