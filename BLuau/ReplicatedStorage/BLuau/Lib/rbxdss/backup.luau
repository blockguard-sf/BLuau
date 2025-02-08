--[[
    backup.luau
    Data backup file for the "rbxdss" package.
    This file allows you to save data simply and securely
--]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Include"):FindFirstChild("BLuau"))

local logging = BLuau.logging

local Module = {}
Module.__index = Module

--- Saves data asynchronously for a specific player and data store.
--- Logs the process and handles any errors that occur.
--- @param player Player The player for whom to save data.
--- @param dataStore string The name of the data store to save data to.
--- @param objectValue any The data to save.
--- @return boolean Success status of the operation.
--- @return nil, string Error message if the operation fails.
function Module:SetAsync(player: Player, dataStore: string, objectValue: any)
    if not player or not dataStore or objectValue == nil then
        return false, "Invalid parameters"
    end

    local self = setmetatable({
        dataStore = DataStoreService:GetDataStore(dataStore)
    }, Module)

    logging.log("Data backup in progress...", "DEBUG")

    local success, err = pcall(function()
        self.dataStore:SetAsync(player.UserId, objectValue)
        logging.log("The data has been saved successfully!", "DEBUG")
    end)

    if not success then
        logging.log(string.format("Error saving data for player %s: %s", player.Name, err), "warn")
        return false, err
    end
    
    return true
end

return Module