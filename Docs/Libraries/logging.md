# logging — Logging Package for Luau

This module provides a logging system for Luau, allowing you to record messages with various priority levels. Inspired by Lua 5.1 syntax and comments, this package offers configuration, log level validation, and log recording functionalities, all integrated within the Roblox environment.

> **Note:** To use this package, simply import it using `require(logging.__init)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Main Functions](#main-functions)
  - [Log Management](#log-management)
  - [Internal Functions](#internal-functions)
- [Dependent Modules](#dependent-modules)
- [Configuration and Behavior](#configuration-and-behavior)
- [Copyright](#copyright)

## Introduction

The `logging` module provides a logging system for Luau. It allows you to:

- Configure logging and set a log threshold.
- Validate log levels.
- Record and display messages with various priority levels.

## Usage

To use the package:

```lua
local logging = require(logging.__init)
logging.log("Your message", "INFO")
```

## Module Contents

### Main Functions

- **`Module.config(logger: boolean?, levelName: string?) -> table | boolean`**  
  Configures the logging module with the specified parameters:

  - `logger`: Enables (`true`) or disables (`false`) additional logging via the Logger module.
  - `levelName`: The log level name from which messages will be processed.

  Returns a configuration table or `false` if the provided values are invalid.

- **`Module.log(message: string, levelName: string) -> table`**  
  Records a message with the specified log level:

  - Automatically determines the execution side (client or server).
  - Validates the log level using the Handlers module.
  - Constructs the log entry and displays it using either `print` or `warn` based on the level (e.g., higher levels like `WARN`).
  - If logging is enabled, it also records the entry using the Logger module.

  Returns a table containing the log information.

- **`Module:__addLevel(level: string, index: number, autoCorrect: boolean?) -> boolean`**  
  Adds a new log level:

  - `level`: Name of the new log level.
  - `index`: Numeric priority of the level.
  - `autoCorrect`: Optional, automatically adjusts the priority in case of conflict.

  If unsuccessful, a warning is displayed and the function returns `false`.

### Log Management

- **`Module.getLog`**  
  Accesses the log data stored in the Logger module.

- **`Module.clear()`**  
  Clears all recorded log entries.

### Internal Functions

These functions are not exported but are essential for the module's operation:

- **`__recoverSide() -> string`**  
  Determines the current execution side (client or server) using Roblox's `RunService`.  
  Returns `"SERVER"` or `"CLIENT"` in uppercase.

- **`__isValidLevel(levelName: string) -> number | boolean`**  
  Validates a given log level by checking the levels defined in the Handlers module.  
  Returns the numeric value of the level if valid, otherwise `false` and issues a warning.

- **`__processLog(source: string, message: string) -> string`**  
  Constructs the log entry from the source and message using the Handlers module.  
  Returns the constructed log entry or an error message if processing fails.

- **`__getLevelName(levelIndex: string) -> string | boolean`**  
  Retrieves the name of the log level corresponding to the given numeric index.  
  Returns the log level name if found, otherwise `false`.

## Dependent Modules

This package relies on two essential modules:

- **Handlers**  
  Manages log levels, constructs log entries, and validates log levels.

- **Logger**  
  Responsible for storing and managing the recorded log data.

## Configuration and Behavior

- **Configuration:**  
  The `Module.config` function allows you to set up the logger behavior and define the priority threshold from which messages will be processed.

- **Log Processing:**  
  When a message is logged using `Module.log`, the module:

  1. Identifies the execution side (client or server).
  2. Validates the log level and its priority.
  3. Constructs the log entry and displays it using `print` or `warn` based on the level.
  4. Records the entry via the Logger module if logging is enabled.

## Copyright

© 2025 BlockGuard SF. All rights reserved.