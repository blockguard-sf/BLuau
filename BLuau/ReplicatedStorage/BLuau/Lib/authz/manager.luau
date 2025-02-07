--[[
    manager.luau
    This file allows for managing player permissions in the game.
    It provides methods for adding and removing permissions from players,
    storing them in a datastore for persistent access control.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = ReplicatedStorage:WaitForChild("BLuau")
local Lib = BLuau:WaitForChild("Lib")

local rbxdss = require(Lib:WaitForChild("rbxdss").__init)

local PERMISSIONS_DATASTORE = "AuthzPlrPerm"

local Module = {}
Module.__index = Module

--- Adds a permission to the specified player.
--- @param player Player The player to add the permission to.
--- @param permission any The permission to add.
--- @return table The module instance.
function Module:addPermission(player: Player, permission: any)
    local self = setmetatable({
        permissions = rbxdss:GetAsync(player, PERMISSIONS_DATASTORE) or {};
        permission = if type(permission) == "string" then permission else tostring(permission)
    }, Module)

    table.insert(self.permissions, self.permission)
    rbxdss:SetAsync(player, PERMISSIONS_DATASTORE, self.permissions)
    return self
end

--- Removes a permission from the specified player.
--- @param player Player The player to remove the permission from.
--- @param permission any The permission to remove.
--- @return table The module instance.
function Module:removePermission(player: Player, permission: any)
    local self = setmetatable({
        permissions = rbxdss:GetAsync(player, PERMISSIONS_DATASTORE) or {};
        permission = if type(permission) == "string" then permission else tostring(permission)
    }, Module)

    for index, perm in ipairs(self.permissions) do
        if perm == self.permission then
            table.remove(self.permissions, index)
            break
        end
    end

    rbxdss:SetAsync(player, PERMISSIONS_DATASTORE, self.permissions)
    return self
end

return Module