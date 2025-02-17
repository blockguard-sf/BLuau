# rbxdss — DataStore Package for Luau

This module provides DataStore operations for Luau on Roblox. It is based on Lua 5.1 syntax and is designed to simplify data saving and retrieval for players using Roblox's DataStoreService. The package also integrates logging to track DataStore operations.

> **Note:** To use this package, simply import it using `require(rbxdss)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Helper Functions](#helper-functions)
  - [Exported Functions](#exported-functions)
    - [SetAsync](#setasync)
    - [GetAsync](#getasync)
- [Logging Integration](#logging-integration)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `rbxdss` package simplifies DataStore operations by providing asynchronous functions to save and retrieve player data. It leverages Roblox's `DataStoreService` and integrates with a logging module to track and report the status of DataStore operations.

## Usage

To use this package, import it in your Luau script:

```lua
local rbxdss = require(rbxdss)
```

You can then perform DataStore operations such as saving or retrieving data for a specific player.

## Module Contents

### Helper Functions

- **`__getDataStore(dataStore: string) -> DataStore?`**  
  Validates the provided DataStore name and retrieves the corresponding DataStore from Roblox's `DataStoreService`.
  - If the `dataStore` name is not a non-empty string, an error log is generated and the function returns `nil`.

### Exported Functions

#### SetAsync

- **`Module:SetAsync(player: Player, datastore: string, objectValue: any) -> boolean & (nil | string)`**  
  Asynchronously saves data for a specific player in the given DataStore.
  
  **Parameters:**
  - `player`: The player whose data will be saved.
  - `datastore`: The name of the DataStore.
  - `objectValue`: The data to be saved.
  
  **Returns:**
  - `true` if the data was saved successfully.
  - `false` along with an error message if an error occurs during saving.
  
  **Behavior:**
  - Retrieves the DataStore using the helper function.
  - Logs the start of the backup process.
  - Uses a protected call (`pcall`) to perform the asynchronous save operation.
  - Logs the result of the operation, including any errors.

#### GetAsync

- **`Module:GetAsync(player: Player, datastore: string) -> any & (nil | string)`**  
  Asynchronously retrieves data for a specific player from the given DataStore.
  
  **Parameters:**
  - `player`: The player whose data will be retrieved.
  - `datastore`: The name of the DataStore.
  
  **Returns:**
  - The retrieved data if the operation is successful.
  - `nil` along with an error message if an error occurs.
  
  **Behavior:**
  - Retrieves the DataStore using the helper function.
  - Logs the fetching process.
  - Uses a protected call (`pcall`) to perform the asynchronous retrieval operation.
  - Logs the result of the operation and returns the retrieved data or an error message.

## Logging Integration

The package integrates with a logging module to:
- Log errors (e.g., invalid DataStore names).
- Track the progress of DataStore operations (e.g., when data saving or retrieval is in progress or completed).
- Provide feedback via different log levels such as `DEBUG` and `WARN`.

## Error Handling

Both the `SetAsync` and `GetAsync` functions utilize Lua's `pcall` for error handling:
- If an error occurs during the DataStore operation, the error is caught, logged, and an appropriate error message is returned.
- This ensures that the calling code can gracefully handle errors without causing runtime interruptions.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.