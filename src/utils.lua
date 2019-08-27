function drawText(text, x, y, color)
    if color ~= nil then
        love.graphics.setColor(color)
    end
    love.graphics.print(text, x, y+3)
end

function setColor(color)
    love.graphics.setColor({color[1]/255, color[2]/255, color[3]/255})
end

function drawFPS()
    setColor({255, 255, 255})
    love.graphics.print(tostring(love.timer.getFPS( )), 8, 8)
end