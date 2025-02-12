--[[  
    Entry point of the BLuau system.  

    This module serves as the main inclusion point for BLuau.  
    It ensures proper dependency loading and provides a structured interface.  

    Author: BlockGuard Software Foundation  
    Version: 1.0.0  
--]]  

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = ReplicatedStorage:WaitForChild("BLuau")
local Core = BLuau:WaitForChild("Core")
local System = Core:WaitForChild("System")

local BLuauLoader = {}

BLuauLoader.Libraries = require(System:WaitForChild("BLuau"))

return BLuauLoader
