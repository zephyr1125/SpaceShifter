testsPlaySpace = {}

function testsPlaySpace:setUp()
    map.slots[1].card = {space = spaces['plain']}
    map.slots[1].card.deck = decks.PlayerDeck
    player.playingCard = {space = spaces['mountain']}
    player.playingCardAsAction = false
    player.targetSlot = 1
end

function testsPlaySpace:tearDown()
    map.slots[1].card = nil
    player.playingCard = nil
    table.clean(decks.PlayerDeck.discardCards)
end

function testsPlaySpace:testChangeMapSlotCard()
    ResolutionState.changeSpace()
    luaunit.assertEquals(map.slots[1].card, player.playingCard)
end

function testsPlaySpace:testOldCardToDiscardPile()
    local oldCard = map.slots[1].card
    ResolutionState.changeSpace()
    luaunit.assertEquals(decks.PlayerDeck.discardCards[1], oldCard)
end