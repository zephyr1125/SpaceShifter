luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

class = require 'lib.hump.class'
love = require 'mock.mocklove'

require('src.utils')
require('src.states.ResolutionState')
require('src.states.UpkeepState')

decks = require('src.entities.Decks')
actions = require('src.entities.Actions')
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

require('src.ui.SelectionGroup')

os.exit( luaunit.LuaUnit.run() )