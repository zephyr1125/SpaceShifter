testsFillAllDecks = {}

function testsFillAllDecks:setUp()

end

function testsFillAllDecks:tearDown()
    for _, deck in pairs(decks) do
        deck.cards = nil
    end
end

function testsFillAllDecks:testAllDecksExecuted()
    fillAllDecks()
    for _, deck in pairs(decks) do
        luaunit.assertNotIsNil(deck.cards)
    end
end

function testsFillAllDecks:testCreateAllCards()
    fillAllDecks()
    for _, deck in pairs(decks) do
        luaunit.assertEquals(#deck.cards, deck.size)
    end
end