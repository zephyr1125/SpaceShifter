local class = require('lib.hump.class')
local keys = require('lib.keys')

local Button = require('ui.button')

local TitleScreen = class {}

local buttonWidth, buttonHeight = 128, 18
local buttonStartY = 180

function TitleScreen:init(ScreenManager)
	self.screen = ScreenManager
	self.startButton = Button('Start Game', buttonWidth, buttonHeight)
	self.exitButton = Button('Exit', buttonWidth, buttonHeight)
end

function TitleScreen:activate()
end

function TitleScreen:draw()
	love.graphics.print('Space Shifter', 10, 10)
	self.startButton:draw((320-buttonWidth)/2, buttonStartY)
	self.exitButton:draw((320-buttonWidth)/2, buttonStartY+buttonHeight)
end

function TitleScreen:keyreleased(key)
	if key == keys.A then
		self.screen:view('game')
	end
end

return TitleScreen