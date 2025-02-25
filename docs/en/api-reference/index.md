---
outline: deep
---

# BLuau - API Reference

This BLuau API reference manual describes its library and usage. It also covers some of the optional components commonly included.

The BLuau API contains modules that provide access to highly general-purpose features, allowing developers to integrate this library across their entire project and experience. Additionally, it includes modules that offer solutions to various common programming challenges. Some of these modules are explicitly designed to encourage developers to better test and optimize their code, ensuring a better gaming experience for Roblox players.

In addition to the standard API, you will be able to create and install community-made modules (ranging from individual programs and modules to complete packages and frameworks). These features are currently unavailable but will be included in future updates.

## Introduction

The "BLuau Library" consists of several different types of components.

Most of the API is made up of a collection of modules. There are many ways to categorize this collection. Some modules provide very specific interfaces for Luau, such as printing a stack trace; others provide Roblox-specific interfaces, and some offer BLuau-specific interfaces.

## Usage

---

### Importing

Importing BLuau into your code has been designed to be simple, intuitive, and easy to understand.
Thus, any developer, whether advanced or not, should be able to use the BLuau API without any issues.
If you have any suggestions for improvements, feel free to let us know.

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau_Rojo").BLibrary)
```

:::details One-line Import

If you want the import process to take up even less space (even though it's already quite concise), you can compress the code like this:

```luau
local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibrary)
```

> [!WARNING]
> Reducing the code even further may result in decreased optimization and reliability.
> The code above is the most reliable way to do it.

:::

To import a module, simply call the variable that interacts with the API in your code and specify the desired module name.

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau_Rojo").BLibrary)

local logging = BLuau.logging -- Importing logging
local unittest = BLuau.unittest -- Importing unittest
```

---

### Standard Library

- [1. Data Persistence](data-persistence/index.html)
   - [1.1. rbxdss — Data Store Management](data-persistence/rbxdss.html)
   - [1.2. authz — Client Authorization Management](data-persistence/authz.html)
- [2. Generic Operating System Services](allos/index.html)
   - [2.1. logging — Advanced Logging](allos/logging.html)
- [3. Development Tools]()
   - [3.1. unittest — Unit Testing Framework]()
   - [3.2. unittest.loader — Dynamic Test Case Loading]()
   - [3.3. unittest.case — Defining and Executing Individual Test Cases]()
   - [3.4. unittest.suite — Grouping Multiple Test Cases]()
   - [3.5. unittest.runner — Automating Test Suite Execution]()
   - [3.6. profiler — Measuring Function Performance]()
   