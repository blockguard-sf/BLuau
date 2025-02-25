---
outline: deep
---

# authz — Client Authorization Management

> **Source Code:** [BLuau/Libraries/authz/__init.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/authz/__init.luau)

## Information

[authz](#authz--client-authorization-management) provides an authorization management system for Luau, enabling role-based access control (RBAC).
It assigns and manages authorizations based on client roles.

> [!Note]
> [Authz](#authz--client-authorization-management) only manages the assignment of permissions and does not enforce permissions.

To function properly, [authz](#authz--client-authorization-management) relies on the [rbxdss](rbxdss.html) module. This means that the [rbxdss usage conditions](rbxdss.html#information) also apply to this module.

## Configuration

By default, authz does not assign player permissions based on their group role but through manual assignment.
However, this can be changed by configuring authz.

| Parameters | Descriptions |
|-|-|
| `Module.__groupId` | Identifier of the reference group for role-based authorizations. |
| `Module.__groupPermissions` | A [table](https://create.roblox.com/docs/luau/tables) defining default permissions for each role. |

These parameters can be modified via the [`authz.config()`](#configure-the-module) function, which allows module configuration.

## Functions

---

### Configure the Module

authz.**config**(_groupId, groupPermissions_)

> Configures the module with the reference group and authorizations.

This function must be called when the server starts and should not be called multiple times to avoid conflicts or synchronization issues with data stores.

> [!CAUTION]
> Modifying permissions while players have already joined the game may cause a desynchronization of permissions between newly assigned permissions and those of existing players.

```luau
PERMISSIONS = {
    ["Admin"] = { "ban_player", "kick_players", "manage_game" },
    ["Moderator"] = { "kick_players", "mute_players" },
    ["Player"] = { "play_game" },
}

-- Assigns group `123456789` and grants permissions
authz.config(123456789, PERMISSIONS)
```

#### Parameters

| Arguments | Descriptions |
|-|-|
| groupId: [Number?](https://create.roblox.com/docs/luau/numbers) | Identifier of the group used for role-based authorizations. |
| groupPermissions: [Table?](https://create.roblox.com/docs/luau/tables) | Defines permissions for each role. |

#### Returns

| Values | Descriptions |
|-|-|
| [Table](https://create.roblox.com/docs/luau/tables) | Contains the last valid configuration of the module. |
| [Boolean?](https://create.roblox.com/docs/luau/booleans) | Returns `false` if invalid values are provided. |

---

### Assign Permissions from a Group

authz:**assignPermissionsFromGroup**(_player_)

> Assigns authorizations to a player based on their role in the specified group.

This function allows predefined permissions to be assigned to a player based on their role in a group.
It manages permissions for all players without requiring manual assignment.

```luau
Players.PlayerAdded:Connect(function(player)
    -- Assigns permissions to players when they join the server
    authz:assignPermissionsFromGroup(player)
end)
```

#### Parameters

| Arguments | Descriptions |
|-|-|
| player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player) | The player to whom permissions will be assigned. |

---

### Assign Permissions

authz:**addPermission**(_player, permission_)

> Adds a specific authorization to a player.

Allows adding a specific authorization to a player without needing to create a group. This function is particularly used by [`authz:assignPermissionsFromGroup()`](#assign-permissions-from-a-group) to add permissions.

> [!WARNING]
> It is not recommended to use this function if you are already managing permissions via a group.
> This may cause synchronization issues between clients and data stores, or even between the client’s supposed permissions and their actual permissions.

```luau
authz:addPermission(player, "manage_server")
```

#### Parameters

| Arguments | Descriptions |
|-|-|
| player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player) | The player to whom the permission will be assigned. |
| permission: [String](https://create.roblox.com/docs/luau/strings) | The permission to be granted. |

#### Returns

| Values | Descriptions |
|-|-|
| [Boolean](https://create.roblox.com/docs/luau/booleans) | Returns `true` if the operation succeeded or `false` if it failed. |

---

### Remove Permissions

authz:**removePermission**(_player, permission_)

> Removes a specific authorization from a player.

Allows removing a specific authorization from a player.
This function is unnecessary if you are already managing authorizations via a group.

```luau
authz:removePermission(player, "manage_server")
```

#### Parameters

| Arguments | Descriptions |
|-|-|
| player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player) | The player from whom the permission will be removed. |
| permission: [String](https://create.roblox.com/docs/luau/strings) | The permission to be removed. |

#### Returns

| Values | Descriptions |
|-|-|
| [Boolean](https://create.roblox.com/docs/luau/booleans) | Returns `true` if the operation succeeded or `false` if it failed. |

---

### Retrieve Player Permissions

authz:**getPermission**(_player_)

> Retrieves the list of authorizations assigned to a player.

```luau
local player_data = authz:getPermission(player, "manage_server")
print(player_data)
```

#### Parameters

| Arguments | Descriptions |
|-|-|
| player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player) | The player whose permissions will be retrieved. |

#### Returns

| Values | Descriptions |
|-|-|
| [Table](https://create.roblox.com/docs/luau/tables) | Contains the current permissions assigned to the player. |