--[[
Additional case for the unittest package for Luau. The core package is based on Lua syntax
version 5.1 and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(unittest.case)' and test your code!
--]]

local TestCase = {}
TestCase.__index = TestCase

export type TestCase = {
	name: string,
	setUp: (self: TestCase) -> (),
	tearDown: (self: TestCase) -> (),
	runTest: (self: TestCase, methodName: string) -> (boolean, string?),
    run: (self: TestCase) -> (boolean, string?),
}

-- Creates a TestCase instance with a name
function TestCase.new(name: string): TestCase
	local self = setmetatable({}, TestCase)
	self.name = name or "UnnamedTest"
	return self
end

function TestCase:setUp() end
function TestCase:tearDown() end

-- Performs the specified test method
function TestCase:runTest(methodName: string): (boolean, string?)
	local success: boolean?, err: nil
	if self.setUp then
		pcall(function(): ()
			self:setUp()
		end)
	end
	success, err = pcall(function(): ()
		self[methodName](self)
	end)
	if self.tearDown then
		pcall(function(): ()
			self:tearDown()
		end)
	end
	return success, err
end

function TestCase:run(): (boolean, string?)
    return self:runTest(self.name)
end

return TestCase
