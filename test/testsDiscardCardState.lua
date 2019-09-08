require('src.states/DiscardCardState')

testsDiscardCardState = {}

function testsDiscardCardState:tearDown()
    
end

function testsDiscardCardState:testConfirmSelection_RemovedCards()
    decks.PlayerDeck.cards = {
        {isDiscardSelected = false},
        {isDiscardSelected = true},
        {isDiscardSelected = true},
    }
    DiscardCardState:confirmSelection()
    
    luaunit.assertEquals(#decks.PlayerDeck.cards, 1)
    for _, card in pairs(decks.PlayerDeck.cards) do
        luaunit.assertIsNil(card.isDiscardSelected)
    end
end