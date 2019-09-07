WinState = {}

local windowWidth = 144
local windowHeight = 48


function WinState:init()
    self.window = Window()
    self.buttons = SelectionGroup()
    self.nextButton = Button('Next', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.switch(RewardState)
            end)
    self.buttons:add(self.nextButton)
    self.windowX = (screenWidth - windowWidth )/2
    self.windowY = (screenHeight - windowHeight)/2
    self.buttonStartY = (screenHeight-windowHeight)/2 + 12 + 8
end

function WinState:draw()
    self.window:draw( self.windowX, self.windowY, windowWidth, windowHeight)
    setColor(white)
    love.graphics.printf('You Win!', self.windowX, self.windowY + 4, windowWidth, 'center')
    self.nextButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY)
end

function WinState:keypressed(key)
    self.buttons:keypressed(key)
end