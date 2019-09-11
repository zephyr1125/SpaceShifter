testsFillAllDecks = {}

function testsFillAllDecks:setUp()

end

function testsFillAllDecks:tearDown()
    decks.PublicDeck.cards = nil
end

function testsFillAllDecks:testAllDecksExecuted()
    fillAllDecks()
    luaunit.assertNotIsNil(decks.PublicDeck)
end

function testsFillAllDecks:testCreateAllCards()
    fillAllDecks()
    luaunit.assertEquals(#decks.PublicDeck.cards, decks.PublicDeck.size)
end