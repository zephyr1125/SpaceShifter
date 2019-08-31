local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
end

function GameScreen:activate()
    math.randomseed(os.time())
    fillAllDecks()
    self.pickCardToPlayerHand(player.handSize)
end

function GameScreen:update(dt)
end

function GameScreen:draw()
    self:drawDecks()
    player:drawHand(120, 160, 200-4)
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
    decks.PlayerDeck:draw(56, 174)
end

function GameScreen.pickCardToPlayerHand(amount)
    decks.PlayerDeck:pickCards(player.hand, amount)
end

return GameScreen