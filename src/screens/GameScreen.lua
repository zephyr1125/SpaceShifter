local GameScreen = class {}

local fillDeckSystem = require('src.systems.FillDeckSystem')

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.uiTestImage = love.graphics.newImage("assets/images/ui_test.png")
    
    world = tiny.world(
            drawNameSystem,
            fillDeckSystem,
            
            player
    )
    for _,deck in pairs(decks) do
        world:add(deck)
    end
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