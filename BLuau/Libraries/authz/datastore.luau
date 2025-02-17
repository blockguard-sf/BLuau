--[[
Additional datastore for the authz package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(authz.datastore)' and manage permissions!
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LIBRARIES_DIRECTORY: Folder = ReplicatedStorage:WaitForChild("BLuau_Rojo"):FindFirstChild("Libraries")
local DATASTORE: string = "AuthzPlrPerm"

local rbxdss: Module = require(LIBRARIES_DIRECTORY.rbxdss)
local logging: Module = require(LIBRARIES_DIRECTORY:WaitForChild("logging").__init)

local function __isValidPermissions(permissions: any): boolean & boolean
	return type(permissions) == "table" and #permissions > 0
end

local Datastore = {}
Datastore.__index = Datastore

--- Retrieves the permissions for the specified player.
function Datastore:GetAsync(player: Player): table
	return rbxdss:GetAsync(player, DATASTORE) or {}
end

--- Sets the permissions for the specified player.
function Datastore:SetAsync(player: Player, permissions: string): any
	if not __isValidPermissions(permissions) then
		return logging.log("Invalid permissions format. Expected a non-empty table.", "WARN")
	end
	return rbxdss:SetAsync(player, DATASTORE, permissions)
end

return Datastore
