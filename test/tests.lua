luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

tiny = require("lib.tiny")
world = tiny.world()

require('src.utils')

decks = require('src.entities.Decks')
actions = require('src.entities.Actions')
spaces =  require('src.entities.Spaces')
player = require('src.entities.Player')
enemies = require('src.entities.Enemies')

require('testsFillDeckSystem')
require('testsOfUtils')

os.exit( luaunit.LuaUnit.run() )