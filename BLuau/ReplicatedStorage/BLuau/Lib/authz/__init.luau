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

return Module
