# UnitTest — Testing Framework for Luau

The `UnitTest` package provides a simple and efficient way to create and execute unit tests in Luau. It follows Lua 5.1 syntax and enables developers to validate their code with structured test cases and assertions.

> **Note:** To use this module, simply require it:  
> ```lua
> local UnitTest = require(unittest.__init)
> ```

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Contents](#module-contents)
  - [Core Components](#core-components)
  - [Running Tests](#running-tests)
  - [Assertions](#assertions)
- [Example Usage](#example-usage)
- [Error Handling](#error-handling)
- [Copyright](#copyright)

## Introduction

The `UnitTest` package consists of multiple modules:
- **`TestCase`** - Defines a single test case.
- **`TestSuite`** - Groups multiple test cases together.
- **`TestLoader`** - Loads tests dynamically.
- **`TestRunner`** - Executes test cases and test suites.

This package provides an easy way to define test cases, group them into test suites, and execute them while displaying results.

## Usage

To use the `UnitTest` package:

```lua
local UnitTest = require(unittest.__init)
```

## Module Contents

### Core Components

- **`UnitTest.TestCase`** - Represents an individual test case.
- **`UnitTest.TestSuite`** - A collection of test cases.
- **`UnitTest.TestLoader`** - Loads tests dynamically.
- **`UnitTest.TestRunner`** - Runs test cases and outputs results.

### Running Tests

- **`UnitTest.run(testInput: { run: () -> {} }, verbose: boolean?): {TestResult}`**  
  Runs a given test suite or test case.

  - **Parameters:**
    - `testInput`: A test suite or test case object with a `run` method.
    - `verbose` (optional): If `true`, prints detailed output.

  - **Returns:**  
    A table containing test results.

  - **Usage:**
    ```lua
    local results = UnitTest.run(myTestSuite, true)
    ```

### Assertions

These functions are used to validate test conditions.

#### assertEqual

- **`UnitTest.assertEqual(actual: any, expected: any, message: string?)`**  
  Checks if two values are equal.

  - **Usage:**
    ```lua
    UnitTest.assertEqual(2 + 2, 4, "Addition failed")
    ```

#### assertNotEqual

- **`UnitTest.assertNotEqual(actual: any, expected: any, message: string?)`**  
  Ensures that two values are different.

  - **Usage:**
    ```lua
    UnitTest.assertNotEqual(3 * 3, 10, "Multiplication failed")
    ```

#### assertTrue

- **`UnitTest.assertTrue(value: any, message: string?)`**  
  Verifies that a value is `true`.

  - **Usage:**
    ```lua
    UnitTest.assertTrue(5 > 2, "Comparison failed")
    ```

#### assertFalse

- **`UnitTest.assertFalse(value: any, message: string?)`**  
  Ensures that a value is `false`.

  - **Usage:**
    ```lua
    UnitTest.assertFalse(1 == 2, "Comparison failed")
    ```

## Example Usage

Here is a simple example of how to define and run a test case:

```lua
local UnitTest = require(unittest.__init)

-- Define a simple test case
local MyTest = {}
function MyTest.run()
    UnitTest.assertEqual(2 + 2, 4, "Addition test failed")
    UnitTest.assertNotEqual(3 * 3, 10, "Multiplication test failed")
    UnitTest.assertTrue(true, "Boolean test failed")
    UnitTest.assertFalse(false, "Boolean test failed")
end

-- Run the test case
UnitTest.run(MyTest, true)
```

## Error Handling

- If the `testInput` passed to `UnitTest.run` does not contain a `run` function, an error is raised.
- Assertions output warnings when they fail, but execution continues.

## Copyright

© 2025 BlockGuard SF. All Rights Reserved.