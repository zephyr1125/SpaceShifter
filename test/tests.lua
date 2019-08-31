luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

require('src.utils')

decks = require('src.entities.Decks')
actions = require('src.entities.Actions')
spaces =  require('src.entities.Spaces')
player = require('src.entities.Player')
enemies = require('src.entities.Enemies')

require('testsOfUtils')
require('testsFillAllDecks')
require('testsPickCards')

os.exit( luaunit.LuaUnit.run() )