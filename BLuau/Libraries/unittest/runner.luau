--[[
Additional runner for the unittest package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(unittest.runner)' and test your code!
--]]

local TestRunner = {}
TestRunner.__index = TestRunner

export type TestResult = { test: string, success: boolean, error: string? }
export type TestRunner = {
	verbose: boolean,
	run: (self: TestRunner, suite: any) -> { TestResult },
}

--- Creates a new TestRunner
function TestRunner.new(verbose: boolean?): TestRunner
	local self = setmetatable({}, TestRunner)
	self.verbose = verbose or false
	return self
end

--- Runs the test suite and displays a detailed report
function TestRunner:run(suite: any): { TestResult }
	local results: any = suite:run()
	local passed: number | number, failed: number | number = 0, 0
	for _, result: any in ipairs(results) do
		if result.success then
			passed = passed + 1
			if self.verbose then
				print(string.format("Test %s: PASSED", result.test))
			end
		else
			failed = failed + 1
			if self.verbose then
				print(string.format("Test %s: FAILED\nErreur: %s", result.test, tostring(result.error)))
			end
		end
	end
	print(string.format("Total tests: %d, Réussis: %d, Échoués: %d", #results, passed, failed))
	return results
end

return TestRunner
