luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

class = require 'lib.hump.class'
love = require 'mock.mocklove'
timer = require('mock.mocktimer')
peachy = require('mock.mockPeachy')

require('src.utils')
require('src.states.ResolutionState')
require('src.states.UpkeepState')
require('src.ui.SelectionGroup')

i18n = require('assets.i18n.en')

require('src.const')
require('src.entities.Card')
actions = require('src.entities.Actions')
decks = require('src.entities.Decks')
spaces =  require('src.entities.Spaces')
map = require('src.entities.Map')
player = require('src.entities.Player')
enemies = require('src.entities.Enemies')
require('src.entities.Card')

require('testsHumpClass')
require('testsOfUtils')
require('testsFillAllDecks')
require('testsPickCards')
require('testsActions')
require('testsMap')
require('testsAttackAndDefence')
require('testsSpaces')
require('testsPlaySpace')
require('testsDiscardCardState')
require('testsAIChooseCards')
require('testsUpkeepState')
require('testsBanshee')
require('testsGhost')


os.exit( luaunit.LuaUnit.run() )