# TestCase — Unit Testing Component for Luau

The `TestCase` module is a fundamental component of the `UnitTest` package. It provides a structure for defining and running individual test cases.

> **Note:** To use this module, simply require it:  
> ```lua
> local TestCase = require(unittest.case)
> ```

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Creating a Test Case](#creating-a-test-case)
  - [Running a Test Method](#running-a-test-method)
  - [Lifecycle Methods](#lifecycle-methods)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `TestCase` module provides a simple interface for defining and executing test cases in Luau. Each `TestCase` instance represents a single test with the ability to set up and tear down test conditions before and after execution.

## Usage

To use `TestCase`, require the module:

```lua
local TestCase = require(unittest.case)
```

## Module Contents

### Creating a Test Case

- **`TestCase.new(name: string): TestCase`**  
  Creates a new test case instance.

  - **Parameters:**
    - `name`: A string representing the test name.
  - **Returns:**  
    A `TestCase` instance.

  - **Usage:**
    ```lua
    local myTest = TestCase.new("MyTest")
    ```

### Running a Test Method

- **`TestCase:runTest(methodName: string): (boolean, string?)`**  
  Executes a specific test method by name.

  - **Parameters:**
    - `methodName`: The name of the test method to execute.
  - **Returns:**  
    - `boolean`: `true` if the test succeeds, `false` if it fails.
    - `string?`: An error message if the test fails.

  - **Usage:**
    ```lua
    local success, errorMessage = myTest:runTest("testExample")
    ```

- **`TestCase:run(): (boolean, string?)`**  
  Runs the test case using its assigned name.

  - **Returns:**  
    - `boolean`: `true` if the test succeeds, `false` otherwise.
    - `string?`: An error message if the test fails.

  - **Usage:**
    ```lua
    local success, errorMessage = myTest:run()
    ```

### Lifecycle Methods

- **`TestCase:setUp()`**  
  A setup method that is executed before each test run. This method is empty by default but can be overridden.

- **`TestCase:tearDown()`**  
  A teardown method that is executed after each test run. This method is empty by default but can be overridden.

  - **Usage:**
    ```lua
    function myTest:setUp()
        -- Initialize test state
    end

    function myTest:tearDown()
        -- Clean up after test
    end
    ```

## Example Usage

```lua
local TestCase = require(unittest.case)

-- Define a test case
local MyTest = TestCase.new("MyTest")

function MyTest:setUp()
    print("Setting up test...")
end

function MyTest:testExample()
    assert(1 + 1 == 2, "Math test failed")
end

function MyTest:tearDown()
    print("Tearing down test...")
end

-- Run the test case
local success, errorMessage = MyTest:run()

if success then
    print("Test passed!")
else
    print("Test failed: " .. tostring(errorMessage))
end
```

## Error Handling

- If the test method does not exist, `runTest` will fail.
- Errors raised inside the test method are caught and returned as error messages.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.