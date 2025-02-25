---
outline: deep
---

# logging — Advanced Logging  

> **Source Code:** [BLuau/Libraries/logging/__init.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/logging/__init.luau)  

## Information  

This module defines functions that implement a flexible event logging system for libraries and your code.  

The main advantage of using the logging API provided by a standard library module is that all BLuau modules can use logging, ensuring that your log can include your own messages along with third-party module messages.  

The only part of BLuau that does not use logging is the internal files, in order to avoid conflicts and looping issues in certain cases.  

The logging system includes different priority levels, which you can define yourself. It is possible to configure the logger's behavior and validate specific logging levels within the Roblox environment.  

## Configuration  

| Parameters        | Descriptions  |  
|------------------|--------------|  
| `Module.__levels` | Logging priority levels. |  
| `Module.__logger` | Enable or disable log recording. |  

These parameters can be modified using the [`logging.config()`](#configure-the-module) function, which allows configuring the module.  

## Functions  

---  

### Configure the Module  

logging.**config**(_logger, levelName_)  

> Configures the logging module.  

This function must be called at server startup and should not be called multiple times to avoid conflicts between different requests.  

```luau  
logging.config(true, "INFO")  
```  

#### Parameters  

| Arguments  | Descriptions  |  
|-----------|--------------|  
| logger: [Boolean?](https://create.roblox.com/docs/luau/booleans) | Enables or disables log recording. |  
| levelName: [String?](https://create.roblox.com/docs/luau/strings) | Logging priority level. |  

#### Returns  

| Values  | Descriptions  |  
|---------|--------------|  
| [Table](https://create.roblox.com/docs/luau/tables) | Contains the last valid module configuration. |  
| [Boolean?](https://create.roblox.com/docs/luau/booleans) | Returns `false` if invalid values are provided. |  

### Send a Log  

logging.**log**(_message, levelName_)  

> Records a message with the specified logging level.  

```luau  
logging.log("YOUR_MESSAGE", "LEVEL_NAME")  
```  

#### Parameters  

| Arguments  | Descriptions  |  
|-----------|--------------|  
| message: [String?](https://create.roblox.com/docs/luau/strings) | The message to log. |  
| levelName: [String?](https://create.roblox.com/docs/luau/strings) | Logging priority level. |  

#### Returns  

| Values  | Descriptions  |  
|---------|--------------|  
| [Table](https://create.roblox.com/docs/luau/tables) | Contains the log entry details. |  

### Retrieve Logs  

logging:**GetLog**()  

> Retrieves log entries stored in the Logger module.  

### Clear Logs  

logging:**Clear**()  

> Clears all recorded log entries.  