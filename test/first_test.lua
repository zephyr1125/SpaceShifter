luaunit = require('luaunit')

-- Add parent path to search list
package.path = package.path .. ";..\\?.lua;"



os.exit( luaunit.LuaUnit.run() )