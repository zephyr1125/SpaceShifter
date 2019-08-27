function drawText(text, x, y, color)
    if color ~= nil then
        love.graphics.setColor(color)
    end
    love.graphics.print(text, x, y+3)
end

function setColor(color)
    love.graphics.setColor({color[1]/256, color[2]/256, color[3]/256})
end