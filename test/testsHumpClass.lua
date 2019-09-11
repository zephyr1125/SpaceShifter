testsHumpClass = {}

function testsHumpClass:test2Instances()
    local Feline = class{
        init = function(self, size)
            self.size = size
            self.elements = {}
        end;
    }

    local garfield = Feline(.7)
    local felix = Feline(.8)

    luaunit.assertEquals(garfield.size, .7)
    luaunit.assertEquals(felix.size, .8)

    table.add(garfield.elements, 'a')
    table.add(felix.elements, 'b')

    luaunit.assertEquals(#garfield.elements, 1)
    luaunit.assertEquals(#felix.elements, 1)
    luaunit.assertEquals(garfield.elements[1], 'a')
    luaunit.assertEquals(felix.elements[1], 'b')
end

function testsHumpClass:testSelectionGroup2Instances()
    local a = SelectionGroup()
    local b = SelectionGroup()
    
    a.name = 'a'
    b.name = 'b'
    luaunit.assertEquals(a.name, 'a')
    luaunit.assertEquals(b.name, 'b')
    
    a:add({name = 'a', setSelect = function(isSelect)end})
    b:add({name = 'b', setSelect = function(isSelect)end})

    luaunit.assertEquals(#a.elements, 1)
    luaunit.assertEquals(#b.elements, 1)
    luaunit.assertEquals(a.elements[1].name, 'a')
    luaunit.assertEquals(b.elements[1].name, 'b')
end