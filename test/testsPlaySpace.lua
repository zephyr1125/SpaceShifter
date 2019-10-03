testsPlaySpace = {}

function testsPlaySpace:setUp()
    map.slots[1].card = Card(nil, spaces.container.circle)
    map.slots[1].card.deck = decks.PlayerDeck
    player.playingCard = Card(nil, spaces.container.fence)
    player.playingCardAsAction = false
    player.targetSlot = 1
    
    currentEnemy.playingCard = Card(actions.container.move)
end

function testsPlaySpace:tearDown()
    map.slots[1].card = nil
    player.playingCard = nil
    table.clean(decks.PlayerDeck.discardCards)
end

function testsPlaySpace:testChangeMapSlotCard()
    ResolutionState:shiftSpace()
    luaunit.assertEquals(map.slots[1].card, player.playingCard)
end

function testsPlaySpace:testOldCardToDiscardPile()
    local oldCard = map.slots[1].card
    ResolutionState:shiftSpace()
    luaunit.assertEquals(decks.PlayerDeck.discardCards[1], oldCard)
end