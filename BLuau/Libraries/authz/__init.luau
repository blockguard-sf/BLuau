--[[
Authz package for Luau. Based on Lua syntax version 5.1.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(authz.__init)' and manage permissions!
--]]

local PACKAGE_DIRECTORY: Folder = script.Parent
local DEFAULT_PERMISSIONS_FOR_ROLES = {
	["Admin"] = { "ban_player", "kick_players", "manage_game" },
	["Moderator"] = { "kick_players", "mute_players" },
	["Player"] = { "play_game" },
}

local Handlers = require(PACKAGE_DIRECTORY:FindFirstChild("handlers"))

local Module = {}
Module.__index = Module

Module.__groupId = nil
Module.__groupPermissions = DEFAULT_PERMISSIONS_FOR_ROLES

local function __getPlayerRole(player: Player): string
	return player:GetRoleInGroup(Module.__groupId)
end

--- Configures the authz module with the specified group and permissions.
function Module.config(groupId: number?, groupPermissions: table?): table | (boolean & table)
	local self = setmetatable({
		groupId = groupId or Module.__groupId,
		groupPermissions = groupPermissions or Module.__groupPermissions,
	}, Module)

	if
		type(groupId) ~= "nil" and type(groupId) ~= "number"
		or type(groupPermissions) ~= "nil" and type(groupPermissions) ~= "table"
	then
		warn("[LOGGING] - Invalid configuration values.")
		return false, self
	end

	Module.__groupId = self.groupId
	Module.__groupPermissions = self.groupPermissions

	return self
end

--- Assigns permissions to a player based on their group role.
--- Retrieves the player's role in the specified group and assigns the corresponding permissions.
function Module:assignPermssionsFromGroup(player: Player): ()
	if Module.__groupId ~= nil then
		local playerRole: string = __getPlayerRole(player)
		local playerPermissions = Module.__groupPermissions[playerRole]

		for _, permission: unknown in ipairs(playerPermissions) do
			Module:addPermission(player, permission)
		end
	end
end

--- Adds a permission to the specified player.
function Module:addPermission(player: Player, permission: string): boolean
	local success: boolean, result: nil = pcall(function(): ()
		Handlers:addPermission(player, permission)
	end)

	if not success then
		warn("[AUTHZ] - Failed to add permission: " .. result)
		return false
	end
	return true
end

--- Removes a permission from the specified player.
function Module:removePermission(player: Player, permission: any): boolean
	local success: boolean, result: nil = pcall(function(): ()
		Handlers:removePermission(player, permission)
	end)

	if not success then
		warn("[AUTHZ] - Failed to remove permission: " .. result)
		return false
	end
	return true
end

--- Removes a permission from the specified player.
function Module:getPermission(player: Player): table
	return Handlers:getPermission(player)
end

return Module
