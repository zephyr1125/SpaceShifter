local class = require('lib.hump.class')
local keys = require('lib.keys')

local Button = require('ui.button')

local TitleScreen = class {}

local buttonWidth, buttonHeight = 128, 18
local buttonStartY = 180
local buttonIdleColor = {0.2, 0.2, 0.2}

function TitleScreen:init(ScreenManager)
	self.screen = ScreenManager
	self.startButton = Button('开始游戏', buttonWidth, buttonHeight, buttonIdleColor)
	self.exitButton = Button('退出游戏', buttonWidth, buttonHeight, buttonIdleColor)
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