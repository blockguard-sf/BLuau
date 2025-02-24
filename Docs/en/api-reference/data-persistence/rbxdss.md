---
outline: deep
---

# rbxdss — Data Store Management

> **Source Code:** [BLuau/Libraries/rbxdss.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/rbxdss.luau)

## Information

[rbxdss](#rbxdss--datastore-package-for-luau) is a simple and secure interface for using Luau's `DataStoreService`.

If the [API services access](https://create.roblox.com/docs/cloud-services/data-stores#enable-studio-access) setting is not enabled, the module will not work, just like `DataStoreService`. In this case, calling a function or the module itself will be useless and will return an error message.

> [!WARNING]
> The server can only access data stores via `Scripts`.  
> Attempting to access them from a `LocalScript` will result in an error.  
> 
> This also applies to the module, which uses data stores to access persistent data.

## Functions

The functions listed in this section are named in a way that makes it easier for developers familiar with `DataStores` to understand.

> [!Note]
> Similarities can be found between this documentation and Roblox's documentation.  
> This is perfectly normal, as [rbxdss](#rbxdss--datastore-module-for-luau) was created to prevent developers from reinventing the wheel and repeatedly writing the same lines of code.

---

### Creating Data

rbxdss:**SetAsync**(_player, datastore, objectValue_)

> Saves a specific player's data in the given DataStore.

This function sets the latest metadata value for the given key.

Network errors are natively handled and encapsulated in [`pcall()`](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals#pcall), so you do not need to manage these errors yourself. However, it is recommended to read about Roblox's native [`SetAsync()`](https://create.roblox.com/docs/reference/engine/classes/GlobalDataStore#SetAsync) function to better understand its usage.

```luau
Players.PlayerAdded:Connect(function(player)
   -- Saves the player's data to `YOUR_DATASTORE`
   rbxdss:SetAsync(player, "YOUR_DATASTORE", "YOUR_DATA")
end)
```

#### Parameters

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|The player whose data will be saved to the data store key.|
|dataStore: [string](https://create.roblox.com/docs/luau/strings)|The key for accessing the data you want to save.|
|objectValue: [any]()|The value to which the data store key will be set.|

#### Returns

|Values|Descriptions|
|-|-|
|[Boolean](https://create.roblox.com/docs/luau/booleans)|Indicates whether the function executed successfully (`true`) or encountered an issue (`false`).|
|[String?](https://create.roblox.com/docs/luau/strings)|If an error occurs, the error message is returned as the second value.|

---

### Reading Data

rbxdss:**GetAsync**(_player, datastore_)

> Retrieves a specific player's data from the given DataStore.

This function reads the value of a data store entry.

You may encounter some synchronization issues with the backend due to [caching behavior](https://create.roblox.com/docs/cloud-services/data-stores/manage-data-stores#caching). These issues are not handled by the function but can be resolved by [disabling caching](https://create.roblox.com/docs/cloud-services/data-stores/manage-data-stores#disable-caching). We recommend doing this when multiple servers frequently write to a key and need to obtain the latest value.

> [!WARNING]
> Disabling caching may lead to higher [data store limits and quotas](https://create.roblox.com/docs/cloud-services/data-stores/error-codes-and-limits#limits).  
> 
> If you exceed this limit, requests will be queued.  
> The queue is limited to 30 requests—if exceeded, new requests will fail.

```luau
Players.PlayerAdded:Connect(function(player)
   -- Retrieves the player's data from `YOUR_DATASTORE`
   local data = rbxdss:GetAsync(player, "YOUR_DATASTORE", "YOUR_DATA")
   print(data)
end)
```

#### Parameters

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|The player whose data will be retrieved from the data store key.|
|dataStore: [string](https://create.roblox.com/docs/luau/strings)|The key for accessing the data you want to retrieve.|

#### Returns

|Values|Descriptions|
|-|-|
|[Tuple](https://create.roblox.com/docs/luau/tuples)|The value of the data store entry for the given key and a [`DataStoreKeyInfo`](https://create.roblox.com/docs/reference/engine/classes/DataStoreKeyInfo) instance that includes the version number, creation date and time, as well as functions for retrieving [user IDs](https://create.roblox.com/docs/reference/engine/classes/Player#UserId) and metadata.|