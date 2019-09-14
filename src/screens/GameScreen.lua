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
    self:drawDecks()
    if currentEnemy~=nil then
        currentEnemy:drawSelectSlot()
        currentEnemy:drawSprite(mapX, mapY)
        currentEnemy:drawInfo(screenWidth-2-cardWidth, 4)
        currentEnemy:drawPlayingCard(enemyCardX, enemyCardY)
    end
    player:drawSprite(mapX, mapY)
    if player.isInited then
        player:drawHand(72, 160, 200)
        player:drawInfo(4, 160)
        infoBar:draw(infoBarX, infoBarY)
    end
    drawFPS()
    drawLogs()
end

function GameScreen:drawBackground()
    setColor({53,53,53})
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
end

function GameScreen:keypressed(key)
    if key == keys.Menu and GameState.current() ~= SystemMenuState then
        GameState.push(SystemMenuState)
    end
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw()
    decks.PlayerDeck:draw()
end

return GameScreen