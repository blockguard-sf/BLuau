# TestLoader — Unit Test Loader for Luau

The `TestLoader` module is part of the `UnitTest` package and is responsible for dynamically loading test cases from a given module.

> **Note:** To use this module, simply require it:  
> ```lua
> local TestLoader = require(unittest.loader)
> ```

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Creating a TestLoader Instance](#creating-a-testloader-instance)
  - [Loading Tests from a Module](#loading-tests-from-a-module)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `TestLoader` module automates the discovery of test functions in a module. It scans a given module for functions whose names start with `"test_"`, then adds them to a `TestSuite`.

## Usage

To use `TestLoader`, require the module:

```lua
local TestLoader = require(unittest.loader)
```

## Module Contents

### Creating a TestLoader Instance

- **`TestLoader.new(): TestLoader`**  
  Creates a new instance of the test loader.

  - **Returns:**  
    A `TestLoader` instance.

  - **Usage:**
    ```lua
    local loader = TestLoader.new()
    ```

### Loading Tests from a Module

- **`TestLoader:loadTestsFromModule(module: { [string]: any }): TestSuite`**  
  Loads all test functions from the specified module and returns them as a `TestSuite`.

  - **Parameters:**
    - `module`: A table representing the module containing test functions.
  - **Returns:**  
    A `TestSuite` containing all discovered test cases.

  - **Usage:**
    ```lua
    local testSuite = loader:loadTestsFromModule(myTestModule)
    ```

## Example Usage

```lua
local TestLoader = require(unittest.loader)

local testModule = {
    test_addition = function()
        assert(1 + 1 == 2, "Addition test failed")
    end,
    test_subtraction = function()
        assert(5 - 3 == 2, "Subtraction test failed")
    end,
    helperFunction = function()
        print("This is not a test and won't be loaded")
    end
}

local loader = TestLoader.new()
local suite = loader:loadTestsFromModule(testModule)

-- Run the loaded test suite
local TestRunner = require(unittest.runner)
local runner = TestRunner.new()
runner:run(suite)
```

## Error Handling

- Functions that do not start with `"test_"` are ignored.
- The module should be a table; otherwise, an error may occur.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.