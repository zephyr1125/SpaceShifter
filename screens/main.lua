local class = require('lib.hump.class')
local keys = require('lib.keys')

local MainScreen = class {}

function MainScreen:init(ScreenManager)
	self.screen = ScreenManager
	self.uiTestImage = love.graphics.newImage("assets/images/ui_test.png")
end

function MainScreen:activate()
end

function MainScreen:draw()
	love.graphics.draw(self.uiTestImage)
	love.graphics.print("Main", 10, 10)
end

function MainScreen:keyreleased(key)
	if key == keys.A then
		self.screen:view('test/index', 'Hello World!')
	end
	
	if key == keys.X then
		self.screen:view('tile')
	end

    if key == keys.Y then
        self.screen:view('suit')
    end
end

return MainScreen