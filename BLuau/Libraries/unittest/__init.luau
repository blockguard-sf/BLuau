--[[
UnitTest package for Luau. Based on a Lua syntax version 5.1 and its comments.

Copyright (c) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(unittest.__init) and test your code!'
--]]

local PACKAGE_DIRECTORY: Folder = script.Parent
local TestCase = require(PACKAGE_DIRECTORY.case)
local TestSuite = require(PACKAGE_DIRECTORY.suite)
local TestLoader = require(PACKAGE_DIRECTORY.loader)
local TestRunner = require(PACKAGE_DIRECTORY.runner)

local Module = {}
Module.__index = Module

Module.TestCase = TestCase
Module.TestSuite = TestSuite
Module.TestLoader = TestLoader
Module.TestRunner = TestRunner

--- Exécute une suite de tests
function Module.run(testInput: { run: () -> {} }, verbose: boolean?): {TestResult}
	local runner: TestRunner = TestRunner.new(verbose)
	if type(testInput) == "table" and testInput.run then
		return runner:run(testInput)
	else
		error("Test suite invalide passé à UnitTest.run")
	end
end

-- Assertion functions to facilitate writing tests.

-- Function for checking that two values ​​are equal.
function Module.assertEqual(actual: any, expected: any, message: string?): ()
	if actual ~= expected then
		warn(message or string.format("Assertion failed: expected %s, got %s", tostring(expected), tostring(actual)))
	end
end

-- Function to check that two values ​​are different.
function Module.assertNotEqual(actual: any, expected: any, message: string?): ()
	if actual == expected then
		warn(message or string.format("Assertion failed: the value should not be %s", tostring(actual)))
	end
end

-- Function to check that a value is true.
function Module.assertTrue(value: any, message: string?): ()
	if not value then
		warn(message or "Assertion failed: the value is not true")
	end
end

-- Function to check that a value is false.
function Module.assertFalse(value: any, message: string?): ()
	if value then
		warn(message or "Assertion failed: the value is not false")
	end
end

return Module
