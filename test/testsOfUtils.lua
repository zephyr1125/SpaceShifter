testsOfUtils = {}

function testsOfUtils:setUp()
    
end

function testsOfUtils:tearDown()
    world:clearEntities()
    world:clearSystems()
    world:update(1)
end

function testsOfUtils:testCreateRandomCard()
    local card = createRandomCard({2,4}, world)
    world:update(1)
    --
    ----card added into world
    luaunit.assertEquals(world:getEntityCount(), 1)
    luaunit.assertEquals(world.entities[1], card)
    --
    --score in range
    local score = card.action.score + card.space.score
    luaunit.assertIsTrue(score >= 2 and score <= 4)
end

return testsOfUtils