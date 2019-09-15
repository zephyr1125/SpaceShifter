SystemMenuState = {}

local windowWidth = 144
local windowHeight = 64+18
local buttonWidth, buttonHeight = 128, 18

function SystemMenuState:enter()
    print('system init')
    self.window = Window()
    self.buttons = SelectionGroup()
    self.returnButton = Button(i18n.back, buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.pop()
            end)
    self.restartButton = Button(i18n.retry, buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.pop()
                GameState.switch(InitState)
            end)
    self.exitButton = Button(i18n.exit, buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function ()
                GameState.switch(IdleState)
                screenManager:view('/')
            end)
    self.buttons:add(self.returnButton)
    self.buttons:add(self.restartButton)
    self.buttons:add(self.exitButton)
    self.buttonStartY = (screenHeight-windowHeight)/2 + 22
end

function SystemMenuState:draw()
    setColor(coverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)


    local windowX = (screenWidth - windowWidth )/2
    local windowY = (screenHeight - windowHeight)/2
    self.window:draw(windowX, windowY, windowWidth, windowHeight)

    setColor(white)
    love.graphics.printf(i18n.system, windowX, windowY + 4, windowWidth, 'center')

    self.returnButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY)
    self.restartButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY+buttonHeight)
    self.exitButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY+buttonHeight*2)
end



function SystemMenuState:keypressed(key)
    self.buttons:keypressed(key)

    if key == keys.Menu then
        GameState.pop()
    elseif key == keys.DPad_up then
        self.buttons:Prev()
    elseif key == keys.DPad_down then
        self.buttons:Next()
    end
end