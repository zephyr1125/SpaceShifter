local M = {}

function M:new(...)
    return {play = function(...)end,
            onLoop = function(...)end,
            stop = function(...)end}
end

return M