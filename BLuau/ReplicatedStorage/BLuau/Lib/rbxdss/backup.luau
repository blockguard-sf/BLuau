--[[
    backup.luau
    Data backup file for the "rbxdss" package.
    This file allows you to save data simply and securely
--]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lib = ReplicatedStorage:FindFirstChild("BLuau"):FindFirstChild("Lib")

local logging = require(Lib:WaitForChild("logging").__init)

local Module = {}
Module.__index = Module

--- Saves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
--- @param player Player The player for whom to save data.
--- @param dataStore string The name of the data store to save data to.
--- @param objectValue any The data to save.
--- @return table The module instance.
function Module:SetAsync(player: Player, dataStore: string, objectValue)
    local self = setmetatable({
        dataStore = DataStoreService:GetDataStore(dataStore)
    }, Module)

    if objectValue then
        logging.log("Data backup in progress...", "debug")
        local success, err = pcall(function()
            self.dataStore:SetAsync(player.UserId, objectValue)
            logging.log("The data has been saved successfully!", "debug")
        end)

        if not success then
            logging.log(`Error saving data for player {player.Name}: {err}`, "WARN")
        end
    end
    return self
end

return Module