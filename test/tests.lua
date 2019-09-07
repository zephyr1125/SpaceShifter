luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

class = require 'lib.hump.class'

require('src.utils')
require('src.states/ResolutionState')

decks = require('src.entities.Decks')
actions = require('src.entities.Actions')
spaces =  require('src.entities.Spaces')
map = require('src.entities.Map')
player = require('src.entities.Player')
enemies = require('src.entities.Enemies')

require('testsHumpClass')
require('testsOfUtils')
require('testsFillAllDecks')
require('testsPickCards')
require('testsActionMove')
require('testsMap')
require('testsAttackAndDefence')
require('testsSpacePlain')
require('testsSpaceMountain')
require('testsPlaySpace')

require('src.ui.SelectionGroup')

os.exit( luaunit.LuaUnit.run() )