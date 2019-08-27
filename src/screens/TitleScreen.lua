local class = require('lib.hump.class')
local keys = require('lib.keys')

local Button = require('src.ui.button')
local SelectionGroup = require('src.ui.SelectionGroup')

local TitleScreen = class {}

local buttonWidth, buttonHeight = 128, 18
local buttonStartY = 180
local buttonIdleColor = {32, 32, 32}
local buttonSelectColor = {136, 151, 166}

function TitleScreen:init(ScreenManager)
	self.screen = ScreenManager
	
	self.buttons = SelectionGroup()
	self.startButton = Button('开始游戏', buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function()
				self.screen:view('game')
			end)
	self.exitButton = Button('退出游戏', buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function ()
				love.event.quit()
			end)
	self.buttons:add(self.startButton)
	self.buttons:add(self.exitButton)
end

function TitleScreen:activate()
end

function TitleScreen:draw()
	love.graphics.print('Space Shifter', 10, 10)
	self.startButton:draw((320-buttonWidth)/2, buttonStartY)
	self.exitButton:draw((320-buttonWidth)/2, buttonStartY+buttonHeight)
end

function TitleScreen:keypressed(key)
	self.buttons:keypressed(key)

	if key == keys.DPad_up then
		self.buttons:Prev()
	elseif key == keys.DPad_down then
		self.buttons:Next()
	end
end

return TitleScreen