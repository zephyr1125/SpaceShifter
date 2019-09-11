testsOfUtils = {}

function testsOfUtils:setUp()
    
end

function testsOfUtils:tearDown()

end

function testsOfUtils:testCreateRandomCard()
    local card = createRandomCard({2,4})
    --
    --score in range
    local score = card.action.score + card.space.score
    luaunit.assertIsTrue(score >= 2 and score <= 4)
end

function testsOfUtils:testGetLifePercent()
    local char = {life = 2, initLife = 10}
    luaunit.assertEquals(getLifePercent(char), 0.2)
end

function testsOfUtils:testChooseHandCardHeal()
    local char = {hand = {
        {action = actions.attack1},
        {action = actions.heal1},
        {action = actions.defence1}}}
    luaunit.assertEquals(chooseHandCardHeal(char), 2)
end

function testsOfUtils:testSortDeck()
    fillAllDecks()
    sortDeck(decks.PublicDeck)
    for i = 1, #decks.PublicDeck.cards-1 do
        card = decks.PublicDeck.cards[i]
        cardNext = decks.PublicDeck.cards[i+1]
        luaunit.assertIsTrue(card.action.score+card.space.score <=
            cardNext.action.score+cardNext.space.score)
    end
end