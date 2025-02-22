--[[
Additional loader for the unittest package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(unittest.loader)' and test your code!
--]]

local TestLoader = {}
TestLoader.__index = TestLoader

export type TestLoader = {
	loadTestsFromModule: (self: TestLoader, module: { [string]: any }) -> any, -- retourne une TestSuite
}

--- Creates a TestLoader instance
function TestLoader.new(): TestLoader
	return setmetatable({}, TestLoader)
end

--- Loads all tests from a module whose name starts with "test_"
function TestLoader:loadTestsFromModule(module: { [string]: any }): TestSuite
	local suite: TestSuite = require(script.Parent.suite).new()
	for key: string, func: any in pairs(module) do
		if type(func) == "function" and key:sub(1, 5) == "test_" then
			local testCase = require(script.Parent.case).new(key)
			testCase[key] = func
			suite:addTest(testCase)
		end
	end
	return suite
end

return TestLoader
