EnemyShowState = {}

function EnemyShowState:enter()
    self.isInfoInside = false
    isEnemyShowed = true
    enemySpecialCardMoveIn(currentEnemy, function()
        self.isInfoInside = true
    end)
end

function EnemyShowState:draw()
    setColor(halfCoverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
    if self.isInfoInside then
        setColor(black)
        love.graphics.rectangle('fill', 0, screenHeight/2-20, screenWidth, 50)
        setColor(white)
        love.graphics.printf(currentEnemy.specialCard.action.info, 0, screenHeight/2+10,
            screenWidth, 'center')
    end
    currentEnemy:drawInfo(enemyInfoPos.x, enemyInfoPos.y)
end

function EnemyShowState:keypressed(key)
    if self.isInfoInside then
        if key == keys.A then 
            enemySpecialCardMoveOut(currentEnemy,function()
                GameState.pop()
            end)
        end
    end
end