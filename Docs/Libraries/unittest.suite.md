# TestSuite — Unit Test Suite for Luau

The `TestSuite` module is part of the `UnitTest` package and is responsible for managing and executing multiple test cases.

> **Note:** To use this module, simply require it:  
> ```lua
> local TestSuite = require(unittest.suite)
> ```

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Creating a TestSuite Instance](#creating-a-testsuite-instance)
  - [Adding Tests](#adding-tests)
  - [Running Tests](#running-tests)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `TestSuite` module allows developers to group multiple test cases and run them as a batch. It keeps track of the results, including passed and failed tests.

## Usage

To use `TestSuite`, require the module:

```lua
local TestSuite = require(unittest.suite)
```

## Module Contents

### Creating a TestSuite Instance

- **`TestSuite.new(): TestSuite`**  
  Creates a new empty test suite.

  - **Returns:**  
    A `TestSuite` instance.

  - **Usage:**
    ```lua
    local suite = TestSuite.new()
    ```

### Adding Tests

- **`TestSuite:addTest(test: Test)`**  
  Adds a single test case to the suite.

  - **Parameters:**
    - `test`: A `Test` instance.

  - **Usage:**
    ```lua
    local testCase = require(unittest.case).new("test_example")
    suite:addTest(testCase)
    ```

- **`TestSuite:addTests(tests: { Test })`**  
  Adds multiple test cases to the suite.

  - **Parameters:**
    - `tests`: A table containing `Test` instances.

  - **Usage:**
    ```lua
    local test1 = require(unittest.case).new("test_one")
    local test2 = require(unittest.case).new("test_two")
    suite:addTests({ test1, test2 })
    ```

### Running Tests

- **`TestSuite:run(): { [number]: { test: string, success: boolean, error: string? } }`**  
  Runs all tests in the suite and returns a table with the results.

  - **Returns:**  
    A table of test results, each containing:
    - `test`: The name of the test.
    - `success`: `true` if the test passed, `false` otherwise.
    - `error`: (optional) Error message if the test failed.

  - **Usage:**
    ```lua
    local results = suite:run()
    for _, result in ipairs(results) do
        print(result.test, result.success and "PASSED" or "FAILED", result.error or "")
    end
    ```

## Example Usage

```lua
local TestSuite = require(unittest.suite)
local TestCase = require(unittest.case)

-- Create test cases
local test1 = TestCase.new("test_addition")
function test1:run()
    return pcall(function()
        assert(1 + 1 == 2, "Addition test failed")
    end)
end

local test2 = TestCase.new("test_subtraction")
function test2:run()
    return pcall(function()
        assert(5 - 3 == 3, "Subtraction test failed") -- Intentional failure
    end)
end

-- Create a test suite and add tests
local suite = TestSuite.new()
suite:addTests({ test1, test2 })

-- Run tests
local results = suite:run()

-- Print results
for _, result in ipairs(results) do
    print(string.format("Test %s: %s", result.test, result.success and "PASSED" or "FAILED"))
    if not result.success then
        print("Error:", result.error)
    end
end
```

### Sample Output:

```plaintext
Test test_addition: PASSED
Test test_subtraction: FAILED
Error: Subtraction test failed
```

## Error Handling

- If a test fails, its error message is captured and included in the results.
- If a test does not have a `run` function, an error may occur.
- Ensure that all tests added to the suite follow the expected `Test` format.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.