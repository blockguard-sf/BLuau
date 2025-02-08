local Module = {}
Module.__index = Module
Module.initialized = true

function Module.main()
    print("Hello world")
end

return Module