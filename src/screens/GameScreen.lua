local GameScreen = class {}

local drawNameSystem = require('src.systems.DrawNameSystem')
local fillDeckSystem = require('src.systems.FillDeckSystem')

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.uiTestImage = love.graphics.newImage("assets/images/ui_test.png")
    
    local joe = {
        name = 'joe'
    }
    world = tiny.world(
            drawNameSystem,
            fillDeckSystem,
            
            player,
            enemies
    )
    for _,deck in pairs(decks) do
        world:add(deck)
    end
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