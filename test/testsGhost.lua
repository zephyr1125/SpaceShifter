testsGhost = {}

function testsGhost:setUp()
    fillAllDecks()
    for _, slot in pairs(map.slots) do
        slot.card = Card(nil, spaces.container.circle)
    end
    ResolutionState:reset()
    player.slot = 1
    player.playingCard = Card(actions.container.move)
    player.targetSlot = 1

    currentEnemy = enemies.container.ghost
    currentEnemy:init()
    currentEnemy.slot = 2
    currentEnemy.hand = {Card(actions.container.move)}
    currentEnemy.targetSlot = 2
end

function testsGhost:testSpecialAttack_AllShiftToGraveyard_And_Continue()
    currentEnemy.specialCounter = 3
    currentEnemy:playCard(player)
    
    ResolutionState:shiftSpace()

    for _, slot in pairs(map.slots) do
        luaunit.assertEquals(slot.card.space, spaces.container.graveyard)
    end

    luaunit.assertIsTrue(ResolutionState.isPlayerShiftSpaceDone)
end

function testsGhost:testSpecialAttack_AllAlreadyGraveyard_Continue()
    for _, slot in pairs(map.slots) do
        slot.card = Card(nil, spaces.container.graveyard)
    end
    currentEnemy.specialCounter = 3
    currentEnemy:playCard(player)

    ResolutionState:shiftSpace()

    luaunit.assertIsTrue(ResolutionState.isPlayerShiftSpaceDone)
end