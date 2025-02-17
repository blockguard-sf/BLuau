# logging.handlers — Additional Handlers for Luau Logging Package

This module provides additional handlers for the Luau logging package. It extends the core logging functionality by managing log levels, constructing log entries with timestamps, and handling the addition of new log levels. The core package is based on Lua 5.1 syntax and its comments.

> **Note:** To use this module, simply import it using `require(logging.handlers)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Data Structures and Internal Variables](#data-structures-and-internal-variables)
  - [Internal Functions](#internal-functions)
  - [Exported Functions](#exported-functions)
- [Log Level Management](#log-level-management)
- [Log Entry Construction](#log-entry-construction)
- [Copyright](#copyright)

## Introduction

The `logging.handlers` module enhances the logging package by:
- Defining a set of default log levels (`DEBUG`, `INFO`, `WARN`, and `ERROR`) with corresponding numeric priorities.
- Providing internal helper functions for validating and adding new log levels.
- Constructing log entries that include a timestamp and formatted message.

## Usage

To use this module, simply require it in your Luau code:

```lua
local Handlers = require(logging.handlers)
```

Once imported, you can use its functions to construct log entries and manage log levels.

## Module Contents

### Data Structures and Internal Variables

- **`Handlers.__levels`**  
  A table defining the default log levels and their numeric priorities:
  - `"DEBUG"`: 0
  - `"INFO"`: 1
  - `"WARN"`: 2
  - `"ERROR"`: 3

- **`Handlers.__internal`**  
  Contains internal utility functions:
  - `timestamp`: Uses `os.date` to get the current date and time.
  - `formatString`: References `string.format` to format log strings.

### Internal Functions

- **`__isValidLevel(levelName: string, levelIndex: number, autoCorrect: boolean) -> table | boolean`**  
  Validates the provided log level name and numeric index:
  - Checks the input types.
  - Warns if the level name already exists.
  - If a duplicate index is found, and `autoCorrect` is enabled, the index is automatically adjusted.
  - Returns a table containing the validated level name and index if valid, otherwise returns `false`.

- **`__timestamp() -> string`**  
  Retrieves the current timestamp formatted as `"%Y-%m-%d %H:%M:%S"` using the internal `timestamp` function.

### Exported Functions

- **`Handlers:__construct(source: string, message: string) -> string & table`**  
  Constructs a new log entry with the given source and message:
  - Generates a timestamp using the internal `__timestamp()` function.
  - Validates that both `source` and `message` are strings.
  - Returns the formatted log entry (as a string) and an instance table containing the timestamp.

- **`Handlers:__addLevel(level: string, index: number, autoCorrect: boolean?) -> boolean & table`**  
  Adds a new log level:
  - Converts the provided `level` to uppercase.
  - Optionally auto-corrects the index if a conflict exists.
  - Validates the new level with `__isValidLevel`.
  - If valid, adds the new level to `Handlers.__levels` and returns `true` along with an instance table containing level details.
  - If unsuccessful, displays a warning and returns `false` with the instance details.

- **`Handlers:GetLevel(levelName: string?) -> number | table`**  
  Retrieves the priority of a specified log level:
  - If a valid level name (string) is provided, returns its numeric priority.
  - If no argument is provided or the level is not found, returns the entire table of log levels.

## Log Level Management

The module automatically handles default log levels but also allows the addition of new log levels through the `__addLevel` function. This function ensures that there are no conflicts in level names or indices, offering an auto-correction option when necessary.

## Log Entry Construction

The `__construct` function builds log entries that include:
- A timestamp in the format `YYYY-MM-DD HH:MM:SS`.
- The source (e.g., client or server) of the log.
- The log message itself, all formatted into a single string for consistency.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.