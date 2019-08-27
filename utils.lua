function drawText(text, x, y, color)
    if color ~= nil then
        love.graphics.setColor(color)
    end
    love.graphics.print(text, x, y+3)
end