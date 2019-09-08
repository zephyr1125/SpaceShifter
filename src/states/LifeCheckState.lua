LifeCheckState = {}

local function returnAllPlayerCards()
    for _, card in pairs(player.hand) do
        decks.PlayerDeck.cards[#decks.PlayerDeck.cards+1] = card
    end
    table.clean(player.hand)
    
    for _, card in pairs(decks.PlayerDeck.discardCards) do
        decks.PlayerDeck.cards[#decks.PlayerDeck.cards+1] = card
    end
    table.clean(decks.PlayerDeck.discardCards)

    for _, slot in pairs(map.slots) do
        if slot.card.deck == decks.PlayerDeck then
            decks.PlayerDeck.cards[#decks.PlayerDeck.cards+1] = slot.card
            slot.card = slot.baseCard
        end
    end
end

function LifeCheckState:enter()
    if player.life <= 0 then
        returnAllPlayerCards()
        GameState.switch(LoseState)
    elseif currentEnemy.life <= 0 then
        returnAllPlayerCards()
        GameState.switch(WinState)
    else
        GameState.switch(PickCardState)
    end
end