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

--- Retrieves the role of a player in a specified group.
--- @param player Player The player to retrieve the role for.
--- @param groupId number The ID of the group to check the player's role in.
--- @return string The role of the player in the group.
local function __getPlayerRole(player: Player, groupId: number)
    return player:GetRoleInGroup(groupId)
end

--- Adds a set of permissions for roles to the module.
--- @param permissions table The table of permissions to add.
--- @return table The module instance.
function Module:addPermissionRoles(permissions: table)
    PERMISSIONS_FOR_ROLES = permissions or {}
end

--- Assigns permissions to a player based on their group role.
--- Retrieves the player's role in the specified group and assigns the corresponding permissions.
--- @param player Player The player to assign permissions to.
--- @param groupId number The ID of the group to check the player's role in.
--- @return table The module instance.
function Module:assignPermissionsFromGroup(player: Player, groupId: number)
    local role = __getPlayerRole(player, groupId)
    local permissions = PERMISSIONS_FOR_ROLES[role] or DEFAULT_PERMISSIONS_FOR_ROLES[role] or {}

    for _, permission in ipairs(permissions) do
        manager:addPermission(player, permission)
    end

    return self
end

return Module