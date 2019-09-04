testsMap = {}

function testsMap:testGetNoHoleNeighbours_NoHole()
    for i = 1, 7 do
        local neighbours = map:getNoHoleNeighbours(i)
        luaunit.assertIsFalse(hasValue(neighbours, 0))
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