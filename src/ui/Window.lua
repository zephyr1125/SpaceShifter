local Window = class {}

function Window:draw(x, y, w, h)
    setColor(windowColor)
    love.graphics.rectangle('fill', x, y, w, h)
end

return Window