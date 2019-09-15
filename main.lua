--[[ 
-- LOADING SCREEN
-- Uncomment to activate
-- Can be an image for example

love.graphics.clear(255,255,255)
local w, h = love.window.getMode()

> love.graphics.draw(...)
> love.graphics.print(...)
> ...

love.graphics.present()
]]--

--log to IDE
io.stdout:setvbuf("no")

logs = {}
--local oldprint = print
--print = function(...)
--	setColor({255, 255, 255})
--	logs[#logs] = ...
--end

class = require('lib.hump.class')
timer = require('lib.hump.timer')
keys = require('lib.keys')
flux = require('lib.flux')
peachy = require('lib.peachy')
require('lib.slam')

require('src.const')
require('src.utils')

-- UI
Button = require('src.ui.Button')
require('src.ui.SelectionGroup')
Window = require('src.ui.Window')
InfoBar = require('src.ui.InfoBar')

-- assets
require('src.assets')



-- Load Libraries
local ScreenManager = require('lib.ScreenManager')
--

-- Load Screens
local TitleScreen = require('src.screens.TitleScreen')
local GameScreen = require('src.screens.GameScreen')
--

-- Game States
GameState = require "lib.hump.gamestate"
require('src.states.IdleState')
require('src.states.InitState')
require('src.states.UpkeepState')
require('src.states.EnemyActionState')
require('src.states.PlayerPlayCardState')
require('src.states.PlayerChooseSlotState')
require('src.states.ResolutionState')
require('src.states.PickCardState')
require('src.states.LifeCheckState')
require('src.states.WinState')
require('src.states.LoseState')
require('src.states.RewardState')
require('src.states.DiscardCardState')
require('src.states.NextEnemyState')
require('src.states.SystemMenuState')
require('src.states.TutorialState')

i18n = require('assets.i18n.en')

-- Load Game
function love.load()
	InitAssets()
	
	map = require('src.entities.Map')
	require('src.entities.Card')
	
	love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
	fontCN = love.graphics.newFont("assets/fonts/en.ttf", fontSize)
    fontCN:setFilter( "nearest", "nearest", 0 )
	love.graphics.setFont(fontCN)
    fontNum = love.graphics.newFont("assets/fonts/cn.ttf", 10)
    fontNum:setFilter( "nearest", "nearest", 0 )
	
	infoBar = InfoBar(infoBarWidth)
	
	screenManager = ScreenManager()
	
	screenManager:register('/', TitleScreen)
	screenManager:register('game', GameScreen)
	
end

local cachetable = {}
for i = 0, math.pi * 2, math.pi / 1000 do
	cachetable[i] = math.sin(i)
end

function love.lowmemory()
	print("low memory")
	cachetable = {}
	collectgarbage()
end


