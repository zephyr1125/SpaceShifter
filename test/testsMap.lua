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

function testsMap:testIsSlotOccupied()
    player.slot = 1
    currentEnemy.slot = 2
    
    luaunit.assertIsTrue(map:isSlotOccupied(1))
    luaunit.assertIsTrue(map:isSlotOccupied(2))
    luaunit.assertIsFalse(map:isSlotOccupied(3))
    
end

function testsMap:testGetBestBenefitNeighbour()
    map.slots[1].card = {space = spaces.graveyard}
    map.slots[2].card = {space = spaces.mountain}
    map.slots[6].card = {space = spaces.plain}
    map.slots[7].card = {space = spaces.graveyard}

    luaunit.assertEquals(map:getBestBenefitNeighbour(1), 2)

    map.slots[1].card = {space = spaces.plain}

    luaunit.assertEquals(map:getBestBenefitNeighbour(1), 1)
end