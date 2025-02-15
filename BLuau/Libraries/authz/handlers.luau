--[[
Additional handlers for the authz package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(authz.handlers)' and manage permissions!
--]]

local PACKAGE_DIRECTORY = script.Parent

local Datastore = require(PACKAGE_DIRECTORY:FindFirstChild("datastore"))

local function __toPermissionString(permission: any): (boolean & string)
    return type(permission) == "string" and permission or tostring(permission)
end

local Handlers = {}
Handlers.__index = Handlers

--- Adds a permission to the specified player.
function Handlers:addPermission(player: Player, permission: any)
    local permissions = Datastore:GetAsync(player)
    local permissionString = __toPermissionString(permission)
    
    if not table.find(permissions, permissionString) then
        table.insert(permissions, permission)
        Datastore:SetAsync(player, permissions)

        if permission ~= "DO_NOT_DELETE" and  #permissions > 1 and table.find(permissions, "DO_NOT_DELETE") then
            Handlers:removePermission(player, "DO_NOT_DELETE")
        end

        Datastore:SetAsync(player, permissions)
    end
end

--- Removes a permission from the specified player.
function Handlers:removePermission(player: Player, permission: any)
    local permissions = Datastore:GetAsync(player) or {}
    local permissionString = __toPermissionString(permission)

    local index = table.find(permissions, permissionString)
    if index then
        if #permissions <= 1 and permission ~= "DO_NOT_DELETE" then
            Handlers:addPermission(player, "DO_NOT_DELETE")
        end

        table.remove(permissions, index)
        Datastore:SetAsync(player, permissions)
    end
end

--- Get a permission from the specified player.
function Handlers:getPermission(player: Player): table
    return Datastore:GetAsync(player)
end

return Handlers