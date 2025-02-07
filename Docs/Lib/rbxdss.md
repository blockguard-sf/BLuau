# Package `rbxdss`

The `rbxdss` package provides a data recovery and backup system for Roblox. It allows retrieving and saving data for players in a simple and secure manner.

## Files

- [`__init.luau`](../../ReplicatedStorage/BLuau/Lib/rbxdss/__init.luau)
- [`recovery.luau`](../../ReplicatedStorage/BLuau/Lib/rbxdss/recovery.luau)
- [`backup.luau`](../../ReplicatedStorage/BLuau/Lib/rbxdss/backup.luau)

## Modules

### `recovery`

The `recovery` module handles data retrieval for players.

#### Functions

- `Module:GetAsync(player: Player, dataStore: string)`
  - Retrieves data asynchronously for a specific player and data store.
  - Logs the process and handles any errors that occur.
  - **Parameters:**
    - `player`: The player for whom to retrieve data.
    - `dataStore`: The name of the data store to retrieve data from.
  - **Returns:** The data retrieved and the module instance if successful, or `nil` if an error occurred.

### `backup`

The `backup` module handles data saving for players.

#### Functions

- `Module:SetAsync(player: Player, dataStore: string, objectValue: any)`
  - Saves data asynchronously for a specific player and data store.
  - Logs the process and handles any errors that occur.
  - **Parameters:**
    - `player`: The player for whom to save data.
    - `dataStore`: The name of the data store to save data to.
    - `objectValue`: The data to save.
  - **Returns:** The module instance.

### `__init`

The main module of the `rbxdss` package.

#### Functions

- `Module:GetAsync(player: Player, dataStore: string)`
  - Retrieves data asynchronously for a specific player and data store.
  - **Parameters:**
    - `player`: The player for whom to retrieve data.
    - `dataStore`: The name of the data store to retrieve data from.
  - **Returns:** The result of the asynchronous recovery operation.

- `Module:SetAsync(player: Player, dataStore: string, objectValue: any)`
  - Saves data asynchronously for a specific player and data store.
  - Logs the process and handles any errors that occur.
  - **Parameters:**
    - `player`: The player for whom to save data.
    - `dataStore`: The name of the data store to save data to.
    - `objectValue`: The data to save.
  - **Returns:** The module instance.

## Usage

To use the `rbxdss` package, simply require it and use its functions:

```lua
local rbxdss = require(ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Lib"):WaitForChild("rbxdss").__init)

-- Retrieve data for a player
local data, moduleInstance = rbxdss:GetAsync(player, "PlayerDataStore")

-- Save data for a player
local moduleInstance = rbxdss:SetAsync(player, "PlayerDataStore", playerData)