--[[
    manager.luau
    This file allows assigning specific permissions to players based on their
    group role and provides a method for adding a custom set of role permissions.
    Permissions are automatically assigned to players according to the group role.
--]]

local PERMISSIONS_FOR_ROLES = {}
local DEFAULT_PERMISSIONS_FOR_ROLES = {
    ["Admin"] = {"ban_player", "kick_players", "manage_game"},
    ["Moderator"] = {"kick_players", "mute_players"},
    ["Player"] = {"play_game"}
}

local manager = require(script.Parent.manager)

local Module = {}
Module.__index = Module

--- Adds a set of permissions for roles to the module.
--- @param permissions table The table of permissions to add.
--- @return table The module instance.
function Module:addPermissionRoles(permissions: table)
    local self = setmetatable({
        permissions = permissions
    }, Module)
    PERMISSIONS_FOR_ROLES = self.permissions
    return self
end

--- Assigns permissions to a player based on their group role.
--- Retrieves the player's role in the specified group and assigns the corresponding permissions.
--- @param player Player The player to assign permissions to.
--- @param groupId number The ID of the group to check the player's role in.
--- @return table The module instance.
function Module:assignPermissionsFromGroup(player: Player, groupId: number)
    local self = setmetatable({
        role = player:GetRoleInGroup(groupId);
        permissions = if PERMISSIONS_FOR_ROLES ~= {} then PERMISSIONS_FOR_ROLES else DEFAULT_PERMISSIONS_FOR_ROLES
    }, Module)
    self.permissions = self.permissions[self.role] or {}

    for _, permission in ipairs(self.permissions) do
        manager:addPermission(player, permission)
    end
    return self
end

return Module