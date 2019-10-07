local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager

    GameState.registerEvents()
    GameState.switch(IdleState)
end

function GameScreen:activate()
    bgmInstance:setVolume(0.4)
    cursor:setVisible(false)
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
    map:draw(mapX, mapY)
    decks.PublicDeck:draw()
    if currentEnemy~=nil then
        currentEnemy:drawSprite(mapX, mapY)
        if currentEnemy.isInited then
            currentEnemy:drawSelectSlot()
            currentEnemy:drawInfo(enemyInfoPos.x, enemyInfoPos.y)
            currentEnemy:drawPlayingCard(enemyCardX, enemyCardY)
        end
    end
    player:drawSprite(mapX, mapY)
    if player.isInited then
        decks.PlayerDeck:draw()
        player:drawHand(72, 160, 200)
        player:drawInfo(4, 160)
        infoBar:draw(infoBarX, infoBarY)
    end
    map:drawCards(mapX, mapY)
    
    cursor:draw()
    --drawFPS()
    --drawLogs()
end

function GameScreen:drawBackground()
    setColor(white)
    love.graphics.draw(imgBackground, 0, 0)
end

function GameScreen:keypressed(key)
    if key == keys.Menu and GameState.current() ~= SystemMenuState then
        GameState.push(SystemMenuState)
    end
end

return GameScreen