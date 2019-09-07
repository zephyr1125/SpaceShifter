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
keys = require('lib.keys')
require('src.const')
require('src.utils')

-- UI
Button = require('src.ui.Button')
require('src.ui.SelectionGroup')
Window = require('src.ui.Window')

-- assets
require('src.assets')

-- Game Data
actions = require('src.entities.Actions')
spaces =  require('src.entities.Spaces')
map = require('src.entities.Map')

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
require('src.states.EnemyActionState')
require('src.states.PlayerPlayCardState')
require('src.states.PlayerChooseSlotState')
require('src.states.ResolutionState')
require('src.states.LifeCheckState')
require('src.states.WinState')
require('src.states.LoseState')
require('src.states.BothDeadState')
require('src.states.PickCardState')

-- Load Game
function love.load()
	InitAssets()
	
	love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
	font = love.graphics.newFont("assets/fonts/zpix.ttf", fontSize)
	font:setFilter( "nearest", "nearest", 0 )
	love.graphics.setFont(font)
	
	screenManager = ScreenManager()
	
	-- Register your screens here (A screen with the path '/' is mandatory!)
	screenManager:register('/', TitleScreen)
	screenManager:register('game', GameScreen)
	
	-- Load the main screen. Only needed if you didn't register a screen with path "/"
	--screenManager:view('test/index', 'Wow!')
end
--

local cachetable = {}
for i = 0, math.pi * 2, math.pi / 1000 do
	cachetable[i] = math.sin(i)
end

function love.lowmemory()
	print("low memory")
	cachetable = {}
	collectgarbage()
end


