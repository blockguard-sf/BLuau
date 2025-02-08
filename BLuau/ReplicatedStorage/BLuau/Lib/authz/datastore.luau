--[[
    datastore.luau
    This file allows retrieving and setting the permissions for players,
    storing them persistently using a datastore.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Include"):FindFirstChild("BLuau"))

local rbxdss = BLuau.rbxdss
local logging = BLuau.logging

local PERMISSIONS_DATASTORE = "AuthzPlrPerm"

local Module = {}
Module.__index = Module

--- Validates that the permissions are in the correct format.
--- @param permissions any The permissions to validate.
--- @return boolean True if valid, false otherwise.
local function __validatePermissions(permissions: any)
    return type(permissions) == "table" and #permissions > 0
end

--- Retrieves the permissions for the specified player.
--- @param player Player The player to retrieve permissions for.
--- @return table The permissions of the player.
function Module:getPermissions(player: Player)
    return rbxdss:GetAsync(player, PERMISSIONS_DATASTORE) or {}
end

--- Sets the permissions for the specified player.
--- @param player Player The player to set permissions for.
--- @param permissions table The permissions to set for the player.
function Module:setPermissions(player: Player, permissions: string)
    if __validatePermissions(permissions) then
        rbxdss:SetAsync(player, PERMISSIONS_DATASTORE, permissions)
    else
        logging.log("Invalid permissions format. Expected a non-empty table.", "WARN")
    end
end

return Module