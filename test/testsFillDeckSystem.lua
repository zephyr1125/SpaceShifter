local fillDeckSystem = require('src.systems.FillDeckSystem')

testsFillDeckSystem = {}

function testsFillDeckSystem:setUp()
    world:add(fillDeckSystem)
    for _,deck in pairs(decks) do
        world:add(deck)
    end
    world:update(1)
end

function testsFillDeckSystem:tearDown()
    world:clearEntities()
    world:clearSystems()
    world:update(1)
end

function testsFillDeckSystem:testAllDecksExecuted()
    world:update(1)
    for _, deck in pairs(decks) do
        luaunit.assertNotIsNil(deck.cards)
    end
end

function testsFillDeckSystem:testCreateAllCards()
    world:update(1)
    for _, deck in pairs(decks) do
        luaunit.assertEquals(#deck.cards, deck.size)
    end
end

return testsFillDeckSystem