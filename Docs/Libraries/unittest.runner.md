# TestRunner — Unit Test Runner for Luau

The `TestRunner` module is part of the `UnitTest` package and is responsible for executing test suites and reporting results.

> **Note:** To use this module, simply require it:  
> ```lua
> local TestRunner = require(unittest.runner)
> ```

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Creating a TestRunner Instance](#creating-a-testrunner-instance)
  - [Running a Test Suite](#running-a-test-suite)
- [Example Usage](#example-usage)
- [Verbose Mode](#verbose-mode)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `TestRunner` module automates the execution of test suites, tracks the number of passed and failed tests, and displays the results in a structured format.

## Usage

To use `TestRunner`, require the module:

```lua
local TestRunner = require(unittest.runner)
```

## Module Contents

### Creating a TestRunner Instance

- **`TestRunner.new(verbose: boolean?): TestRunner`**  
  Creates a new instance of the test runner.

  - **Parameters:**
    - `verbose`: (optional) If `true`, detailed test results will be printed.

  - **Returns:**  
    A `TestRunner` instance.

  - **Usage:**
    ```lua
    local runner = TestRunner.new(true) -- Enable verbose mode
    ```

### Running a Test Suite

- **`TestRunner:run(suite: TestSuite): { TestResult }`**  
  Runs the given test suite and prints a summary.

  - **Parameters:**
    - `suite`: A `TestSuite` instance containing test cases.

  - **Returns:**  
    A table containing the results of each test case.

  - **Example Result Format:**
    ```lua
    {
        { test = "test_addition", success = true, error = nil },
        { test = "test_subtraction", success = false, error = "Expected 2, got 3" },
    }
    ```

  - **Usage:**
    ```lua
    local results = runner:run(myTestSuite)
    ```

## Example Usage

```lua
local TestRunner = require(unittest.runner)
local TestLoader = require(unittest.loader)

local testModule = {
    test_addition = function()
        assert(1 + 1 == 2, "Addition test failed")
    end,
    test_subtraction = function()
        assert(5 - 3 == 3, "Subtraction test failed") -- Intentional failure
    end
}

local loader = TestLoader.new()
local suite = loader:loadTestsFromModule(testModule)

local runner = TestRunner.new(true) -- Enable verbose mode
local results = runner:run(suite)
```

## Verbose Mode

When `verbose` mode is enabled, the runner provides detailed output:

```plaintext
Test test_addition: PASSED
Test test_subtraction: FAILED
Error: Subtraction test failed
Total tests: 2, Passed: 1, Failed: 1
```

## Error Handling

- If a test fails, the error message is captured and displayed.
- If the test suite is not valid, an error may occur.
- If `verbose` is enabled, failure details are printed.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.