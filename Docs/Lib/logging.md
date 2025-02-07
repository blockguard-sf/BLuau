# Package `logging`

The `logging` package provides a logging management system for client and server-side scripts in Roblox. It allows defining different log levels, adding log entries, and configuring the logger's behavior.

## Files

- [`__init.luau`](BLuau/ReplicatedStorage/BLuau/Lib/logging/__init.luau)
- [`handlers.luau`](BLuau/ReplicatedStorage/BLuau/Lib/logging/handlers.luau)
- [`logger.luau`](BLuau/ReplicatedStorage/BLuau/Lib/logging/logger.luau)

## Modules

### `logger`

The `logger` module manages log entries.

#### Functions

- `Module:SetLog(level: string, logEntry: string)`
  - Sets a log entry for the specified log level.
  - **Parameters:**
    - `level`: The log level.
    - `logEntry`: The log entry to set.

- `Module:GetLog()`
  - Retrieves all log entries.
  - **Returns:** A table containing all log entries.

### `handlers`

The `handlers` module manages log levels and constructs log entries.

#### Functions

- `Module.add(level: string, priority: number, autoCorrect: boolean)`
  - Adds a new log level with the specified priority.
  - **Parameters:**
    - `level`: The name of the new log level.
    - `priority`: The priority value of the new log level.
    - `autoCorrect`: If true, automatically corrects priority conflicts.
  - **Returns:** `true` if the log level was added successfully, otherwise `false`.

- `Module:GetLevel(level: string?)`
  - Retrieves the priority of the specified log level or the complete list of log levels if no level is specified.
  - **Parameters:**
    - `level`: The name of the log level to retrieve (optional).
  - **Returns:** The priority of the specified log level or the complete list of log levels.

### `__init`

The main module of the `logging` package.

#### Functions

- `Module.log(message: string, level: string)`
  - Logs a message with the specified log level.
  - **Parameters:**
    - `message`: The message to log.
    - `level`: The log level for the message.
  - **Returns:** The log entry object.

- `Module.config(logger: boolean?, level: string?)`
  - Configures the logging module with the specified logger and log level.
  - **Parameters:**
    - `logger`: Enable or disable the logger (optional).
    - `level`: The log level to set as the threshold (optional).
  - **Returns:** The module instance if successful, otherwise `false`.

- `Module.addLevel(level: string, priority: string, autoCorrect: boolean)`
  - Adds a new log level with the specified priority.
  - **Parameters:**
    - `level`: The name of the new log level.
    - `priority`: The priority value of the new log level.
    - `autoCorrect`: If true, automatically corrects priority conflicts.
  - **Returns:** `true` if the log level was added successfully, otherwise `false`.

- `Module:GetLog()`
  - Retrieves all log entries from the logger.
  - **Returns:** A table containing all log entries.

## Usage

To use the `logging` package, simply require it and use its functions:

```lua
local logging = require(ReplicatedStorage:WaitForChild("BLuau"):WaitForChild("Lib"):WaitForChild("logging").__init)

-- Configure the logger
logging.config(true, "INFO")

-- Add a custom log level
logging.addLevel("TRACE", 0, true)

-- Log a message
logging.log("This is an info message", "INFO")

-- Retrieve all log entries
local logs = logging:GetLog()