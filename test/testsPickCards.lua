testsPickCards = {}

function testsPickCards:setUp()
    fillAllDecks()
end

function testsPickCards:tearDown()
    decks.PublicDeck.cards = nil
end

function testsPickCards:testPickPublicDeckCards()
    local hand = decks.PublicDeck:pickCards(2)
    
    luaunit.assertEquals(#hand, 2)
    luaunit.assertNotIsNil(hand[1].action)
    luaunit.assertNotIs(hand[1].space)
end