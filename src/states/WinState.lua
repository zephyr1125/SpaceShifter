WinState = {}

local windowWidth = 144
local windowHeight = 48 + 14

local function onComplete()
    for id, slot in pairs(map.slots) do
        timer.after(id*0.2, function()
            local card = slot.baseCard
            card:flip()
        end)
    end
    GameState.switch(RewardState)
end

function WinState:init()
    self.window = Window()
    self.buttons = SelectionGroup()
    self.nextButton = Button(i18n.next, buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                self.isDrawWindow = false
                for id, slot in pairs(map.slots) do
                    timer.after(id*0.2, function()
                        local card = slot.baseCard
                        local callback = (id == #map.slots) and onComplete or nil
                        card:moveTo(rewardCardX+(id-1)*rewardCardInterval, rewardCardY, 0.4, callback)
                    end)
                end
            end)
    self.buttons:add(self.nextButton)
    self.windowX = (screenWidth - windowWidth )/2
    self.windowY = (screenHeight - windowHeight)/2
    self.buttonStartY = (screenHeight-windowHeight)/2 + 12 +14 + 8
end

function WinState:enter()
    player:upgrade()
    self.isDrawWindow = true
end

function WinState:draw()
    if self.isDrawWindow then
        self.window:draw( self.windowX, self.windowY, windowWidth, windowHeight)
        setColor(white)
        love.graphics.printf(i18n.win, self.windowX, self.windowY + 4, windowWidth, 'center')
        love.graphics.printf(i18n.update, self.windowX, self.windowY + 4+14, windowWidth, 'center')
        self.nextButton:draw((screenWidth-buttonWidth)/2, self.buttonStartY)
    end
end

function WinState:keypressed(key)
    self.buttons:keypressed(key)
end