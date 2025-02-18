# authz.handlers — Additional Handlers for the Authz Package

This module provides additional permission management functionalities for the `authz` package. It interacts with the `datastore` module to store and retrieve player permissions efficiently.

> **Note:** To use this module, simply import it using `require(authz.handlers)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Helper Functions](#helper-functions)
  - [Permission Management](#permission-management)
    - [addPermission](#addpermission)
    - [removePermission](#removepermission)
    - [getPermission](#getpermission)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `authz.handlers` module is responsible for:
- Adding and removing permissions for players.
- Storing permissions in a persistent datastore.
- Preventing the last permission from being removed by using a `DO_NOT_DELETE` safeguard.

This module works as an extension of `authz.__init`.

## Usage

To use the permission handlers:

```lua
local Handlers = require(authz.handlers)
```

## Module Contents

### Helper Functions

- **`__toPermissionString(permission: any): boolean & string`**  
  Converts any type of input into a string representation.  
  - Returns `true, permission` if it's already a string.  
  - Otherwise, converts it to a string.

### Permission Management

#### addPermission

- **`Handlers:addPermission(player: Player, permission: any)`**  
  Adds a permission to the specified player and stores it in the datastore.

  - **Parameters:**
    - `player`: The player to whom the permission will be added.
    - `permission`: The permission string or identifier.

  - **Behavior:**
    - Retrieves the player's current permissions.
    - Converts the permission to a string if necessary.
    - Adds the permission if it is not already present.
    - If a non-default permission is added and `"DO_NOT_DELETE"` exists, `"DO_NOT_DELETE"` is removed.

  - **Usage:**
    ```lua
    Handlers:addPermission(player, "manage_game")
    ```

#### removePermission

- **`Handlers:removePermission(player: Player, permission: any)`**  
  Removes a permission from the specified player and updates the datastore.

  - **Parameters:**
    - `player`: The player from whom the permission will be removed.
    - `permission`: The permission string or identifier.

  - **Behavior:**
    - Retrieves the player's current permissions.
    - Converts the permission to a string if necessary.
    - Removes the permission if it exists.
    - If it was the last permission (except `"DO_NOT_DELETE"`), `"DO_NOT_DELETE"` is added to maintain datastore integrity.

  - **Usage:**
    ```lua
    Handlers:removePermission(player, "manage_game")
    ```

#### getPermission

- **`Handlers:getPermission(player: Player): table`**  
  Retrieves the list of permissions assigned to a player from the datastore.

  - **Parameters:**
    - `player`: The player whose permissions will be retrieved.

  - **Returns:**
    - A table containing the player's assigned permissions.

  - **Usage:**
    ```lua
    local permissions = Handlers:getPermission(player)
    print("Player Permissions:", permissions)
    ```

## Example Usage

```lua
local Handlers = require(authz.handlers)

local player = game.Players:GetPlayerFromUserId(789012)

-- Add a permission
Handlers:addPermission(player, "edit_map")

-- Retrieve player permissions
local playerPermissions = Handlers:getPermission(player)
print("Player Permissions:", playerPermissions)

-- Remove a permission
Handlers:removePermission(player, "edit_map")
```

## Error Handling

- The `__toPermissionString` function ensures all permissions are stored as strings.
- If an invalid player object is passed, datastore operations may fail.
- The `"DO_NOT_DELETE"` permission is used as a safeguard to prevent an empty permission table.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.