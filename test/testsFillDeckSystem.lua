local fillDeckSystem = require('src.systems.FillDeckSystem')

world = tiny.world()

tests = {}
    function tests:setUp()
        world:add(fillDeckSystem)
        for _,deck in pairs(decks) do
            world:add(deck)
        end
    end

    function tests:tearDown()
        world:clearEntities()
        world:clearSystems()
        fillDeckSystem.world = nil
    end

    function tests:testAllDecksExecuted()
        world:update(1)
        for _, deck in pairs(decks) do
            luaunit.assertNotIsNil(deck.cards)
        end
    end

return tests