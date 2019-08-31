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
    self:initEnemy()
end

function GameScreen:initEnemy()
    self.currentEnemyId = 1
    self.currentEnemy = enemies[self.currentEnemyId]
    self.currentEnemy:init()
end

function GameScreen:update(dt)
end

function GameScreen:draw()
    self:drawDecks()
    player:drawHand(120, 160, 200-4)
    player:drawInfo(4, screenHeight-4-cardHeight)
    if self.currentEnemy ~= nil then
        self.currentEnemy:drawInfo(screenWidth-4-cardWidth, 4)
    end
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

    if key == keys.Y then
        player.cardAsAction = not player.cardAsAction
    end
end

function GameScreen:drawDecks()
    decks.PublicDeck:draw(4, 4)
    decks.PlayerDeck:draw(4+48+4, screenHeight-4-cardHeight)
end

return GameScreen