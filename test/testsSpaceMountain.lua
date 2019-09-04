testsSpaceMountain = {}

function testsSpaceMountain:setUp()
    ResolutionState.reset()
end

function testsSpaceMountain:tearDown()
    ResolutionState.reset()
end

function testsSpaceMountain:testMountainAffectDefence()
    player.playingCard = {action = actions['move']}
    player.playingCardAsAction = true
    player.slot = 1
    player.targetSlot = 1
    map.slots[1].card = {space = spaces['mountain']}
    currentEnemy.slot = 2
    map.slots[2].card = {space = spaces['mountain']}
    ResolutionState.extraDefence()

    luaunit.assertEquals(player.defence, 1)
    luaunit.assertEquals(currentEnemy.defence, 1)
end