local rbxdss = require(game.ReplicatedStorage:WaitForChild('BLuau'):WaitForChild("Lib"):WaitForChild("rbxdss"):WaitForChild("__init"))
local Players = game:GetService("Players")

local function onPlayerAdded(player)
    local t, _ = rbxdss:GetAsync(player, "test")
    print(t)
    rbxdss:SetAsync(player, "test", 25687)
    local a, _ = rbxdss:GetAsync(player, "test")
    print(a)
end

Players.PlayerAdded:Connect(onPlayerAdded)