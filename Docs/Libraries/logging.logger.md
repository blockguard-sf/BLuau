# logging.logger — Additional Logger for Luau Logging Package

This module provides an additional logger for the Luau logging package. It manages the storage and retrieval of log entries. The core package is based on Lua 5.1 syntax and its comments.

> **Note:** To use this module, simply import it using `require(logging.logger)`.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Data Structures](#data-structures)
  - [Exported Functions](#exported-functions)
- [Log Entry Storage](#log-entry-storage)
- [Log Clearing](#log-clearing)
- [Copyright](#copyright)

## Introduction

The `logging.logger` module is designed to work in conjunction with the main logging package by storing log entries. It collects logs by level and message, allowing for centralized log management within your Luau project.

## Usage

To use the logger module, simply require it in your Luau code:

```lua
local Logger = require(logging.logger)
```

Once imported, you can record log entries with the provided functions.

## Module Contents

### Data Structures

- **`Logger.__data`**  
  A table that holds all the log entries. Each entry is a table containing:
  - `level`: The log level as a string.
  - `message`: The log message as a string.

### Exported Functions

- **`Logger.setLog(levelName: string, logEntry: string) -> boolean`**  
  Adds a new log entry for the specified log level.
  
  - **Parameters:**
    - `levelName`: The name of the log level (must be a string).
    - `logEntry`: The log message (must be a string).
  
  - **Returns:**  
    `true` if the log entry was added successfully, otherwise `false`.
  
  - **Behavior:**  
    Validates the input types and inserts the log entry into the `Logger.__data` table. If the types are invalid, a warning is displayed and the function returns `false`.

- **`Logger.clear() -> boolean`**  
  Clears all stored log entries.
  
  - **Returns:**  
    `true` if the log entries were cleared successfully, otherwise `false`.
  
  - **Behavior:**  
    Uses a protected call (`pcall`) to attempt to clear the `Logger.__data` table using `table.clear`. If an error occurs during the clearing process, a warning is displayed with the error message.

## Log Entry Storage

The module stores all log entries in a centralized table (`Logger.__data`). Each log entry consists of the log level and the message, which facilitates easy retrieval and potential processing or display by other parts of the logging package.

## Log Clearing

The `Logger.clear` function is used to remove all log entries from the storage. It employs a protected call to ensure that errors during the clearing process are caught and handled gracefully.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.