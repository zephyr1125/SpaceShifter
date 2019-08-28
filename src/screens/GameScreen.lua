local GameScreen = class {}

local drawNameSystem = require('src.systems.DrawNameSystem')
local fillDeckSystem = require('src.systems.FillDeckSystem')

local publicDeck = require('src.entities.PublicDeck')
local player = require('src.entities.Player')
local enemies = require('src.entities.Enemies')

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.uiTestImage = love.graphics.newImage("assets/images/ui_test.png")
    
    local joe = {
        name = 'joe'
    }
    world = tiny.world(
            drawNameSystem,
            fillDeckSystem,
    
            publicDeck,
            player,
            enemies
    )
    world:add(joe)
end

function GameScreen:activate()
    
end

function GameScreen:update(dt)
    world:update(dt)
end

function GameScreen:draw()
    love.graphics.draw(self.uiTestImage)
    drawFPS()
    drawLogs()
end

function GameScreen:keypressed(key)
    if key == keys.B then
        self.screen:view('/')
    end
end

return GameScreen