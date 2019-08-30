local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
end

function GameScreen:activate()
    self:fillAllDecks()
end

function GameScreen:update(dt)
end

function GameScreen:draw()
    self:drawDecks()
    drawFPS()
    drawLogs()
end

function GameScreen:keypressed(key)
    if key == keys.B then
        self.screen:view('/')
    end
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw(30, 60)
end

return GameScreen