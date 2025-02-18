# authz — Authorization Package for Luau

This module provides an authorization system for Luau, enabling role-based access control (RBAC). It assigns and manages permissions based on group roles.

> **Note:** To use this package, simply import it using `require(authz.__init)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Configuration](#configuration)
  - [Permission Management](#permission-management)
    - [config](#config)
    - [assignPermissionsFromGroup](#assignpermissionsfromgroup)
    - [addPermission](#addpermission)
    - [removePermission](#removepermission)
    - [getPermission](#getpermission)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `authz` module allows developers to:
- Define role-based permissions for a group.
- Assign permissions to players based on their roles.
- Dynamically add or remove permissions for players.
- Retrieve a player's permissions.

It is designed to work with Roblox groups and integrates with a handler system for managing permissions.

## Usage

To use the authorization system:

```lua
local Authz = require(authz.__init)
```

Once imported, you can configure and manage permissions for players in your game.

## Module Contents

### Configuration

- **`Module.__groupId`**  
  The ID of the group used for role-based permissions.

- **`Module.__groupPermissions`**  
  A table defining the default permissions for each role.

- **`DEFAULT_PERMISSIONS_FOR_ROLES`**  
  A predefined set of permissions assigned to roles like `"Admin"`, `"Moderator"`, and `"Player"`.

### Permission Management

#### config

- **`Module.config(groupId: number?, groupPermissions: table?): table | (boolean & table)`**  
  Configures the authorization module with a group ID and a permissions table.

  - **Parameters:**
    - `groupId` (optional): The ID of the group to be used for role-based permissions.
    - `groupPermissions` (optional): A table defining role-based permissions.

  - **Returns:**
    - A table containing the current configuration.
    - Returns `false` and the config table if invalid values are provided.

  - **Errors:**
    - Logs a warning if invalid values are provided.

#### assignPermissionsFromGroup

- **`Module:assignPermissionsFromGroup(player: Player): ()`**  
  Assigns permissions to a player based on their group role.

  - **Behavior:**
    - Retrieves the player's role in the specified group.
    - Assigns permissions based on the predefined role-based permission table.

  - **Usage:**
    ```lua
    local player = game.Players:GetPlayerFromUserId(123456)
    Authz:assignPermissionsFromGroup(player)
    ```

#### addPermission

- **`Module:addPermission(player: Player, permission: any): boolean`**  
  Adds a permission to a specific player.

  - **Parameters:**
    - `player`: The player to whom the permission will be added.
    - `permission`: The permission string or identifier.

  - **Returns:**
    - `true` if successful.
    - `false` if the operation fails.

  - **Errors:**
    - Logs a warning if adding the permission fails.

#### removePermission

- **`Module:removePermission(player: Player, permission: any): boolean`**  
  Removes a permission from a specific player.

  - **Parameters:**
    - `player`: The player from whom the permission will be removed.
    - `permission`: The permission string or identifier.

  - **Returns:**
    - `true` if successful.
    - `false` if the operation fails.

  - **Errors:**
    - Logs a warning if removing the permission fails.

#### getPermission

- **`Module:getPermission(player: Player): table`**  
  Retrieves the list of permissions assigned to a player.

  - **Parameters:**
    - `player`: The player whose permissions will be retrieved.

  - **Returns:**
    - A table containing the player's assigned permissions.

## Example Usage

```lua
local Authz = require(authz.__init)

-- Configure the system with a group ID
Authz.config(123456, {
    ["Admin"] = { "ban_player", "kick_players", "manage_game" },
    ["Moderator"] = { "kick_players", "mute_players" },
    ["Player"] = { "play_game" },
})

local player = game.Players:GetPlayerFromUserId(789012)

-- Assign permissions from the player's group role
Authz:assignPermissionsFromGroup(player)

-- Manually add a permission
Authz:addPermission(player, "edit_map")

-- Retrieve player permissions
local playerPermissions = Authz:getPermission(player)
print("Player Permissions:", playerPermissions)

-- Remove a permission
Authz:removePermission(player, "edit_map")
```

## Error Handling

- The `config` function will log a warning if invalid parameters are passed.
- The `addPermission` and `removePermission` functions will log warnings if the operations fail.
- If an invalid player object is provided, permission operations may fail.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.