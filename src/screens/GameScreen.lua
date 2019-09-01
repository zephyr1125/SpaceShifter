GameState = require "lib.hump.gamestate"

local GameScreen = class {}

InitState = {}
require('src.states.InitState')
EnemyActionState = {}
require('src.states.EnemyActionState')

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.imgMapSlot = love.graphics.newImage("assets/images/map_slot.png")
end

function GameScreen:activate()
    GameState.registerEvents()
    GameState.switch(InitState)
end

function GameScreen:update(dt)
end

function GameScreen:draw()
    map:draw(self.imgMapSlot, 46, 56)
    self:drawDecks()
    player:drawHand(120, 160, 200-4)
    player:drawInfo(4, screenHeight-4-cardHeight)
    if currentEnemy ~= nil then
        currentEnemy:drawInfo(screenWidth-4-cardWidth, 4)
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