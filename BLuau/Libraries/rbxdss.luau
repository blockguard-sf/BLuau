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
		return false
	end
	return DataStoreService:GetDataStore(dataStore)
end

local Module = {}
Module.__index = Module

Module.CacheEnabled = true
Module.Cache = {}

--- Enables or disables the cache based on the provided boolean value.
--- Logs an error message if the provided value is not a boolean.
function Module:setCacheEnabled(value: boolean): ()
    if type(value) == "boolean" then
        Module.CacheEnabled = value
        return
    end

    logging.log(`Invalid Value: {type(value)}, expected value: Boolean`, "ERROR")
    return
end

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

	if Module.CacheEnabled then
		if type(Module.Cache[datastore]) ~= table then
			Module.Cache[datastore] = {}
		end
		Module.Cache[datastore][player.UserId] = objectValue
		logging.log("Saving cached data.", "DEBUG")
	end

	logging.log("The data has been saved successfully!", "DEBUG")
	return true
end

function Module:RemoveAsync(player: Player, dataStore): string
	local store = __getDataStore(dataStore)
	if not store then 
		return "Invalid DataStore"
	end

	logging.log(`Deleting data {dataStore} at {player}.`, "DEBUG")

	local success, removedValue = pcall(function(): (any, DataStoreKeyInfo)
		logging.log("Suppression des données ", "DEBUG")
		return store:RemoveAsync(player.UserId)
	end)

	if not success then
		logging.log(`{removedValue}`, "ERROR")
		return false
	end

	if Module.CacheEnabled and Module.Cache[dataStore] and Module.Cache[dataStore][player.UserId] then
		logging.log("Deleting data in cache.", "DEBUG")
		Module.Cache[dataStore][player.UserId] = nil
	end
	return
end

--- Retrieves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
function Module:GetAsync(player: Player, datastore: string): string
	local store: DataStore? = __getDataStore(datastore)
	if not store then
		return "Invalid DataStore"
	end

	logging.log(`Fetching data for UserId {player.UserId} from DataStore "{datastore}".`, "DEBUG")

	if Module.CacheEnabled and Module.Cache[datastore] and Module.Cache[datastore][player.UserId] then
		logging.log("Data retrieved successfully with cache.", "DEBUG")
		return Module.Cache[datastore][player.UserId]
	else
		local success: boolean, result: any = pcall(function(): (any, DataStoreKeyInfo)
			return store:GetAsync(player.UserId)
		end)

		if not success then
			logging.log(`Failed to retrieve data: {result}`, "WARN")
			return result
		end

		if Module.CacheEnabled then
			if type(Module.Cache[datastore]) ~= table then
				Module.Cache[datastore] = {}
			end
			Module.Cache[datastore][player.UserId] = result
			logging.log("Saving cached data.", "DEBUG")
		end

		logging.log("Data retrieved successfully.", "DEBUG")
		return result
	end
end

return Module
