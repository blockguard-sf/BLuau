--[[
    recovery.luau
    Data recovery file for the "rbxdss" package.
    This file allows you to recovery data simply and securely
--]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Libraries = ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Modules"):FindFirstChild("Libraries")

local logging = require(Libraries:WaitForChild("logging").__init)

local Module = {}
Module.__index = Module

--- Retrieves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
--- @param player Player The player for whom to retrieve data.
--- @param dataStore string The name of the data store to retrieve data from.
--- @return table|nil The data retrieved if successful, or nil if an error occurred.
--- @return nil, string Error message if the operation fails.
function Module:GetAsync(player: Player, dataStore: string)
    if not player or not dataStore then
        return nil, "Invalid parameters"
    end
    
    local self = setmetatable({
        dataStore = DataStoreService:GetDataStore(dataStore)
    }, Module)

    logging.log("Data recovery requested.", "DEBUG")

    local success, result = pcall(function()
        self.data = self.dataStore:GetAsync(player.UserId)
        logging.log("The request data was successfully retrieved!", "DEBUG")
        return self.data
    end)

    if not success then
        logging.log(result, "WARN")
        return nil, result
    end
    
    return result
end

return Module