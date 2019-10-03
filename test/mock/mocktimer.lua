local M = {}

function M.tween(time, self, subject, method, after, ...)
    if after ~= nil then
        after()
    end
end

function M.after(...)
    
end

return M