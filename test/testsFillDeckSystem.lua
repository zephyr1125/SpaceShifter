local fillDeckSystem = require('src.systems.FillDeckSystem')

world = tiny.world()

tests = {}
    function tests:setUp()
        joe = {
            size = '3',
            score = '1'
        }
        
        world:add(fillDeckSystem, joe)
    end

    function tests:tearDown()
        world:clearEntities()
        world:clearSystems()
        fillDeckSystem.world = nil
    end

    function tests:testUpdated()
        
        
        world:update(1)
        
        luaunit.assertEquals(joe.cards, 2)
    end

    function tests:testUpdated2()
        joe.score = nil
    
        world:update(1)
    
        luaunit.assertEquals(joe.cards, nil)
    end

return tests