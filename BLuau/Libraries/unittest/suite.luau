--[[
Additional case for the unittest package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(unittest.suite)' and test your code!
--]]

local TestSuite = {}
TestSuite.__index = TestSuite

export type Test = { run: () -> (boolean, string?), name: string }
export type TestSuite = {
	tests: { Test },
	addTest: (self: TestSuite, test: Test) -> (),
	addTests: (self: TestSuite, tests: { Test }) -> (),
	run: (self: TestSuite) -> { [number]: { test: string, success: boolean, error: string? } },
}

-- Creates a new test suite
function TestSuite.new(): TestSuite
	local self = setmetatable({}, TestSuite)
	self.tests = {}
	return self
end

-- Adds an individual test afterwards
function TestSuite:addTest(test: any): ()
	table.insert(self.tests, test)
end

-- Adds several tests in a row
function TestSuite:addTests(tests: { any }): ()
	for _, test: any in ipairs(tests) do
		self:addTest(test)
	end
end

-- Runs all tests in the suite and returns a report
function TestSuite:run(): { [number]: { test: string, success: boolean, error: string? } }
	local results: {{ error: string?, success: boolean, test: string }} = {}
	for _, test: unknown in ipairs(self.tests) do
		local success: any, err: any = test:run()
		table.insert(results, { test = test.name, success = success, error = err })
	end
	return results
end

return TestSuite
