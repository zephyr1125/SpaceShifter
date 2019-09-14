SystemMenuState = {}

local windowWidth = 144
local windowHeight = 64+18
local buttonWidth, buttonHeight = 128, 18

function SystemMenuState:init()
    self.window = Window()
    self.buttons = SelectionGroup()
    self.returnButton = Button('返回', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.pop()
            end)
    self.restartButton = Button('重来', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                GameState.pop()
                GameState.switch(InitState)
            end)
    self.exitButton = Button('退出', buttonWidth, buttonHeight,
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
    local windowX = (screenWidth - windowWidth )/2
    local windowY = (screenHeight - windowHeight)/2
    self.window:draw(windowX, windowY, windowWidth, windowHeight)

    setColor(white)
    love.graphics.printf('系统', windowX, windowY + 4, windowWidth, 'center')

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