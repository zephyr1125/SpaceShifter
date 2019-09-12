local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager

    GameState.registerEvents()
    GameState.switch(IdleState)
end

function GameScreen:activate()
    GameState.switch(InitState)
end

function GameScreen:update(dt)
    player:update(dt)
    timer.update(dt)
    flux.update(dt)
end

function GameScreen:draw()
    local state = GameState.current()
    if state == RewardState or state == DiscardCardState then
        return
    end
    
    self:drawBackground()
    map:draw(imgMapSlot, mapX, mapY)
    currentEnemy:drawSprite(mapX, mapY)
    player:drawSprite(mapX, mapY)
    self:drawDecks()
    player:drawHand(72, 160, 200)
    player:drawInfo(4, 160)
    if currentEnemy ~= nil then
        currentEnemy:drawInfo(screenWidth-2-cardWidth, 4)
        currentEnemy:drawPlayingCard(enemyCardX, enemyCardY)
    end
    infoBar:draw(infoBarX, infoBarY)
    drawFPS()
    drawLogs()
end

function GameScreen:drawBackground()
    setColor({53,53,53})
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
end

function GameScreen:keypressed(key)
    
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw(4, 4)
    decks.PlayerDeck:draw(276, 160)
end

return GameScreen