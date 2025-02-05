--[[
    recovery.luau
    Data recovery file for the "rbxdss" package.
    This file allows you to recovery data simply and securely
--]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lib = ReplicatedStorage:FindFirstChild("BLuau"):FindFirstChild("Lib")

local logging = require(Lib:WaitForChild("logging").__init)

local Module = {}
Module.__index = Module

--- Retrieves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
--- @param player Player The player for whom to retrieve data.
--- @param dataStore string The name of the data store to retrieve data from.
--- @return table|nil The data retrieved and the module instance if successful, or nil if an error occurred.
function Module:GetAsync(player: Player, dataStore: string)
    local self = setmetatable({
        dataStore = DataStoreService:GetDataStore(dataStore)
    }, Module)

    logging.log("Data recovery required requested.", "debug")
    local success, err = pcall(function()
        self.data = self.dataStore:GetAsync(player.UserId)
        logging.log("The request data was successfully retrieved!", "debug")
    end)

    if not success then
        logging.log(err, "warn")
    end
    
    return self.data or nil, self
end

return Module