local class = require('lib.hump.class')
local keys = require('lib.keys')

local MainScreen = class {}

function MainScreen:init(ScreenManager)
	self.screen = ScreenManager
end

function MainScreen:activate()
end

function MainScreen:draw()
	love.graphics.print("Main", 10, 10)
end

function MainScreen:keyreleased(key)
	if key == keys.A then
		self.screen:view('test/index', 'Hello World!')
	end
	
	if key == keys.X then
		self.screen:view('tile')
	end
end

return MainScreen