local GameScreen = class {}

function GameScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.uiTestImage = love.graphics.newImage("assets/images/ui_test.png")
end

function GameScreen:activate()
end

function GameScreen:draw()
    love.graphics.draw(self.uiTestImage)
end

function GameScreen:keypressed(key)
    if key == keys.B then
        self.screen:view('/')
    end
end

return GameScreen