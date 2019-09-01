local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.imgMapSlot = love.graphics.newImage("assets/images/map_slot.png")

    GameState.registerEvents()
    GameState.switch(InitState)
end

function GameScreen:activate()
    GameState.switch(InitState)
end

function GameScreen:update(dt)
end

function GameScreen:draw()
    map:draw(self.imgMapSlot, mapX, mapY)
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