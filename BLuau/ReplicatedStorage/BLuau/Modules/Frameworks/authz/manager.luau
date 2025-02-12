--[[
    manager.luau
    This file allows for managing player permissions in the game.
    It provides methods for adding and removing permissions from players,
    storing them in a datastore for persistent access control.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lib = ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Lib")

local rbxdss = require(Lib:WaitForChild("rbxdss").__init)

local PERMISSIONS_DATASTORE = "AuthzPlrPerm"

local Module = {}
Module.__index = Module

--- Retrieves the permissions for a player from the datastore.
--- @param player Player The player to retrieve permissions for.
--- @return table The permissions table.
local function __getPermissions(player: Player)
    return rbxdss:GetAsync(player, PERMISSIONS_DATASTORE) or {}
end

--- Saves the permissions for a player to the datastore.
--- @param player Player The player to save permissions for.
--- @param permissions table The permissions table to save.
local function __savePermissions(player: Player, permissions: table)
    rbxdss:SetAsync(player, PERMISSIONS_DATASTORE, permissions)
end

--- Converts a permission to a string if it is not already.
--- @param permission any The permission to convert.
--- @return string The permission as a string.
local function __toPermissionString(permission: any)
    return type(permission) == "string" and permission or tostring(permission)
end

--- Adds a permission to the specified player.
--- @param player Player The player to add the permission to.
--- @param permission any The permission to add.
--- @return table The module instance.
function Module:addPermission(player: Player, permission: any)
    local permissions = __getPermissions(player)
    local permissionString = __toPermissionString(permission)

    if not table.find(permissions, permissionString) then
        table.insert(self.permissions, self.permission)
        __savePermissions(player, permissions)
    end

    return self
end

--- Removes a permission from the specified player.
--- @param player Player The player to remove the permission from.
--- @param permission any The permission to remove.
--- @return table The module instance.
function Module:removePermission(player: Player, permission: any)
    local permissions = __getPermissions(player)
    local permissionString = __toPermissionString(permission)
    local index = table.find(permissions, permissionString)

    if index then
        table.remove(self.permissions, index)
        __savePermissions(player, permissions)
    end

    return self
end

return Module