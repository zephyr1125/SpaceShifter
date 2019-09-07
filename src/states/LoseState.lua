LoseState = {}

local windowWidth = 144
local windowHeight = 48
local buttonWidth, buttonHeight = 128, 18

function LoseState:init()
    self.window = Window()
    self.buttons = SelectionGroup()
    self.restartButton = Button('Restart', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.switch(InitState)
            end)
    self.exitButton = Button('Exit', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function ()
                GameState.switch(IdleState)
                screenManager:view('/')
            end)
    self.buttons:add(self.restartButton)
    self.buttons:add(self.exitButton)
    self.buttonStartY = (screenHeight-windowHeight)/2 + 8
end

function LoseState:draw()
    self.window:draw((screenWidth - windowWidth )/2, (screenHeight - windowHeight)/2,
        windowWidth, windowHeight)
    self.restartButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY)
    self.exitButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY+buttonHeight)
end

function LoseState:keypressed(key)
    self.buttons:keypressed(key)

    if key == keys.DPad_up then
        self.buttons:Prev()
    elseif key == keys.DPad_down then
        self.buttons:Next()
    end
end