local function callConstructor(class, obj, ...)
    local meta = getmetatable(class)
    if meta.__super then
        if class.superArgs then
            callConstructor(meta.__super, obj, class.superArgs(...))
        else
            callConstructor(meta.__super, obj)
        end
    end
    if class.constructor then
        class.constructor(obj, ...)
    end
end

local function instantiate(class, ...)
    local ret = setmetatable({}, {
        __index = class
    })
    callConstructor(class, ret, ...)
    return ret
end

function Class(name, superclass)
    local ret = {}
    setmetatable(ret, {
        __index = function(self, key)
            if key ~= "constructor" and superclass then
                return superclass[key]
            end
            return nil
        end,
        --__index = superclass,
        __super = superclass,
        __call = instantiate,
        __tostring = function() return name or "unknown" end
    })
    return ret
end

-- vim: set filetype=lua :
