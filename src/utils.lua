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

function drawLogs()
    setColor({255, 255, 255})
    for _,log in pairs(logs) do
        love.graphics.print(log, 8, 16)
    end
    
end

--Create card and add to world
function createRandomCard(scoreRange, world)
    --random action and space
    local action, space, totalScore
    repeat
        action = actions[math.random(#actions)]
        space = spaces[math.random(#spaces)]
        totalScore = action.score + space.score
    until totalScore >= scoreRange[1] and totalScore <= scoreRange[2]
    
    local card = {action = action, space = space}
    world:add(card)
    return card
end