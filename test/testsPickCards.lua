testsPickCards = {}

function testsPickCards:setUp()
    fillAllDecks()
end

function testsPickCards:tearDown()
    for _, deck in pairs(decks) do
        deck.cards = nil
    end
end

function testsPickCards:testPickPublicDeckCards()
    local hand = {}
    decks.PublicDeck:pickCards(hand, 2)
    
    luaunit.assertEquals(#hand, 2)
    luaunit.assertNotIsNil(hand[1].action)
    luaunit.assertNotIs(hand[1].space)
end

return testsPickCards