local TitleScreen = class {}

local buttonWidth, buttonHeight = 128, 18
local buttonStartY = 180


function TitleScreen:init(ScreenManager)
	self.screen = ScreenManager
	
	self.buttons = SelectionGroup()
	self.startButton = Button('Start', buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function()
				self.screen:view('game')
			end)
	self.exitButton = Button('Exit', buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function ()
				love.event.quit()
			end)
	self.buttons:add(self.startButton)
	self.buttons:add(self.exitButton)
end

function TitleScreen:activate()
end

function TitleScreen:draw()
	--love.graphics.print('Space Shifter', 10, 10)
	self.startButton:draw((screenWidth-buttonWidth)/2, buttonStartY)
	self.exitButton:draw((screenWidth-buttonWidth)/2, buttonStartY+buttonHeight)
	setColor(white)
	love.graphics.draw(imgPreview, 0, 0)
	drawFPS()
	drawLogs()
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