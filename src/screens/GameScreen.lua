local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
end

function GameScreen:activate()
    decks = reload('src.entities.Decks')
    player = reload('src.entities.Player')
    enemies = reload('src.entities.Enemies')
    
    math.randomseed(os.time())
    fillAllDecks()
    player:init()
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

    if key == keys.DPad_right then
        player:selectPrev()
    end

    if key == keys.DPad_left then
        player:selectNext()
    end
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw(4, 4)
    decks.PlayerDeck:draw(4+48+4, 174)
end

return GameScreen