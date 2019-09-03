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