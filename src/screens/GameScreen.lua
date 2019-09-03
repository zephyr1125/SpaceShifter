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
end

function GameScreen:draw()
    self:drawBackground()
    map:draw(imgMapSlot, mapX, mapY)
    currentEnemy:drawSprite(mapX, mapY)
    player:drawSprite(mapX, mapY)
    self:drawDecks()
    player:drawHand(120, 160, 200-2)
    player:drawInfo(2, screenHeight-2-cardHeight)
    if currentEnemy ~= nil then
        currentEnemy:drawInfo(screenWidth-2-cardWidth, 2)
        currentEnemy:drawPlayingCard(216, 2)
    end
    drawFPS()
    drawLogs()
end

function GameScreen:drawBackground()
    setColor({53,53,53})
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
end

function GameScreen:keypressed(key)
    if key == keys.B then
        self.screen:view('/')
    end
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw(4, 4)
    decks.PlayerDeck:draw(4+48+4, screenHeight-4-cardHeight)
end

return GameScreen