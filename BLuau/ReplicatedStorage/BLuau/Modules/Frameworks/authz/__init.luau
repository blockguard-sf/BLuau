--[[
Authz package for Luau. Based on Luau syntax in Lua 5.1
and its comments.

Copyright (C) 2025-2025 BlockGuard SF. All Rights Reserved.

To use, simply 'require(authz.__init)' and log away!
--]]

--[[
    __init.luau
    Main file of the "authz" package.
    This file allows the game to interact with the package in a simple and
    secure way.
--]]

local Module = {}
Module.__index = Module

Module.Manager = require(script.Parent.manager)
Module.Roles = require(script.Parent.roles)
Module.Datastore = require(script.Parent.datastore)

--- Checks if the required submodules are loaded.
--- Throws an error if any of the required submodules are missing.
local function __checkModules()
    if not Module.Manager or not Module.Roles or not Module.Datastore then
        error("Failed to load one or more required modules.")
    end
end

--- Initializes the module by checking the required submodules.
--- @return table The module instance.
function Module:init()
    __checkModules()
    return self
end

return Module:init()
