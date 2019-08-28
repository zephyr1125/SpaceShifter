luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"

tiny = require("lib.tiny")

require('testsFillDeckSystem')

os.exit( luaunit.LuaUnit.run() )