testsMap = {}

function testsMap:testGetNoHoleNeighbours_NoHole()
    for i = 1, 7 do
        local neighbours = map:getNoHoleNeighbours(i)
        luaunit.assertIsFalse(table.contains(neighbours, 0))
    end
end

function testsMap:testRandomNeighbour_No0()
    for i = 1, 500 do
        local neighbour = map:randomNeighbour(i%7 + 1)
        luaunit.assertNotIs(neighbour, 0)
    end
end

function testsMap:testRandomNeighbour_NoExceptValues()
    for i = 1, 500 do
        local neighbour = map:randomNeighbour(1, 2)
        luaunit.assertNotIs(neighbour, 2)
    end
end

function testsMap:testGetSlotOccupied()
    player.slot = 1
    currentEnemy.slot = 2
    
    luaunit.assertEquals(map:getSlotOccupied(1), player)
    luaunit.assertEquals(map:getSlotOccupied(2), currentEnemy)
    luaunit.assertIsNil(map:getSlotOccupied(3))
    
end

function testsMap:testGetBestBenefitNeighbour()
    map.slots[1].card = {space = spaces.container.graveyard}
    map.slots[2].card = {space = spaces.container.mountain}
    map.slots[6].card = {space = spaces.container.canyon}
    map.slots[7].card = {space = spaces.container.graveyard}

    luaunit.assertEquals(map:getBestBenefitNeighbour(1), 6)

    map.slots[1].card = {space = spaces.container.canyon}

    luaunit.assertEquals(map:getBestBenefitNeighbour(1), 1)
end