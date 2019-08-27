local class = require('lib.hump.class')
local keys = require('lib.keys')
local suit = require('lib.suit')

local SuitTestScreen = class {}

function SuitTestScreen:init(ScreenManager)
    self.screen = ScreenManager
    self.showMessage = false
end

function SuitTestScreen:activate()
end

function SuitTestScreen:update()
    if suit.Button("Hello, World!", 8,8, 304,32).hit then
        self.showMessage = true
    end

    -- if the button was pressed at least one time, but a label below
    if self.showMessage then
        suit.Label("How are you today?", 8,34, 304,32)
    end
end

function SuitTestScreen:draw()
    suit.draw()
end

function SuitTestScreen:keyreleased(key)
    if key == keys.Y then
        self.screen:view('/')
    end
end

return SuitTestScreen