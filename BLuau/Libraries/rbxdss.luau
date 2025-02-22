--[[
RbxDSS package for Luau. Based on Lua syntax version 5.1.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(rbxdss.__init)' and use DataStore operations!
--]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LIBRARIES_DIRECTORY: Folder = ReplicatedStorage:WaitForChild("BLuau_Rojo"):FindFirstChild("Libraries")

local logging: Module = require(LIBRARIES_DIRECTORY:WaitForChild("logging").__init)

local function __getDataStore(dataStore: string): DataStore?
	if typeof(dataStore) ~= "string" or dataStore == "" then
		logging.log("Invalid DataStore name provided.", "ERROR")
		return nil
	end
	return DataStoreService:GetDataStore(dataStore)
end

local Module = {}
Module.__index = Module

--- Saves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
function Module:SetAsync(player: Player, datastore: string, objectValue: any): boolean & (nil | string)
	local store: DataStore? = __getDataStore(datastore)
	logging.log("Data backup in progress... ", "DEBUG")

	local success: boolean, errMsg: nil = pcall(function(): ()
		store:SetAsync(player.UserId, objectValue)
	end)

	if not success then
		logging.log(`Error saving data for player {player.Name}: {errMsg}`, "WARN")
		return false, errMsg
	end
	logging.log("The data has been saved successfully!", "DEBUG")
	return true
end

--- Retrieves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
function Module:GetAsync(player: Player, datastore: string): any & (nil | string)
	local store: DataStore? = __getDataStore(datastore)
	if not store then
		return nil, "Invalid DataStore"
	end

	logging.log(`Fetching data for UserId {player.UserId} from DataStore "{datastore}".`, "DEBUG")

	local success: boolean, result: any = pcall(function(): (any, DataStoreKeyInfo)
		return store:GetAsync(player.UserId)
	end)

	if not success then
		logging.log(`Failed to retrieve data: {result}`, "WARN")
		return nil, result
	end

	logging.log("Data retrieved successfully.", "DEBUG")
	return result
end

return Module
