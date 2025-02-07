--[[
    datastore.luau
    This file allows retrieving and setting the permissions for players,
    storing them persistently using a datastore.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = ReplicatedStorage:WaitForChild("BLuau")
local Lib = BLuau:WaitForChild("Lib")

local rbxdss = require(Lib:WaitForChild("rbxdss").__init)

local PERMISSIONS_DATASTORE = "AuthzPlrPerm"

local Module = {}
Module.__index = Module

--- Retrieves the permissions for the specified player.
--- @param player Player The player to retrieve permissions for.
--- @return table The permissions of the player.
function Module:getPermissions(player: Player)
    return rbxdss:GetAsync(player, PERMISSIONS_DATASTORE) or {}
end

--- Sets the permissions for the specified player.
--- @param player Player The player to set permissions for.
--- @param permissions string The permissions to set for the player.
function Module:setPermissions(player: Player, permissions: string)
    rbxdss:SetAsync(player, PERMISSIONS_DATASTORE, permissions)
end

return Module