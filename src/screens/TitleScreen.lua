local TitleScreen = class {}

local buttonWidth, buttonHeight = 128, 18
local buttonStartY = 194-18

local language = 'en'

function TitleScreen:init(ScreenManager)
	musicBGM:setLooping(true)
	musicBGM:setVolume(1)
	bgmInstance = musicBGM:play()

	self.screen = ScreenManager
	
	self.buttons = SelectionGroup()
	self.startButton = Button(i18n.start, buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function()
				self.screen:view('game')
			end)
	self.i18nButton = Button(i18n.language, buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function ()
				if language == 'cn' then
					language = 'en'
				else
					language = 'cn'
				end
				i18n = reload('assets.i18n.'..language)
				self:refreshLanguage()
			end)
	self.exitButton = Button(i18n.exit, buttonWidth, buttonHeight,
			buttonIdleColor, buttonSelectColor, function ()
				love.event.quit()
			end)
	self.buttons:add(self.startButton)
	self.buttons:add(self.i18nButton)
	self.buttons:add(self.exitButton)
end

function TitleScreen:refreshLanguage()
	self.startButton.text = i18n.start
	self.i18nButton.text = i18n.language
	self.exitButton.text = i18n.exit
end

function TitleScreen:activate()
	bgmInstance:setVolume(1)
end

function TitleScreen:activate()
end

function TitleScreen:draw()
	setColor(white)
	love.graphics.draw(imgBackground, 0, 0)
	love.graphics.draw(imgName, (screenWidth - 198)/2, (screenHeight-88)/2 - buttonHeight)
	--love.graphics.print('Space Shifter', 10, 10)
	self.startButton:draw((screenWidth-buttonWidth)/2, buttonStartY)
	self.i18nButton:draw((screenWidth-buttonWidth)/2, buttonStartY+buttonHeight)
	self.exitButton:draw((screenWidth-buttonWidth)/2, buttonStartY+buttonHeight*2)
	setColor(white)
	--drawFPS()
	--drawLogs()
end

function TitleScreen:keypressed(key)
	self.buttons:keypressed(key)

	if key == keys.DPad_up then
		self.buttons:Prev()
	elseif key == keys.DPad_down then
		self.buttons:Next()
	elseif key == keys.Menu then
			love.event.quit()
	end
end

return TitleScreen