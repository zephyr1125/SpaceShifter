
world = tiny.world()

tests = {}
function tests:setUp()
    
end

function tests:tearDown()
    world:clearEntities()
    world:clearSystems()
end

function tests:testCreateRandomCard()
    local card = createRandomCard({2,4}, world)
    world:update(1)
    
    --card added into world
    luaunit.assertEquals(world:getEntityCount(), 1)
    luaunit.assertEquals(world.entities[1], card)
    
    --score in range
    local score = card.action.score + card.space.score
    luaunit.assertIsTrue(score >= 2 and score <= 4)
end

return tests