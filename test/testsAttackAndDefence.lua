testsAttackAndDefence = {}

function testsAttackAndDefence:setUp()
    ResolutionState:reset()
    player.slot = 1
end

function testsAttackAndDefence:tearDown()
    ResolutionState:reset()
end

function testsAttackAndDefence:testCorrectDamageCalc()
    player.playingCard = Card(actions.container.attack1)
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.life = 5
    currentEnemy.defence = 1
    currentEnemy.slot = 2
    map.slots[1].card = Card(nil, spaces.container.circle)
    
    player.playingCard.action:effect(player, currentEnemy)
    ResolutionState.calcDamage()
    
    luaunit.assertEquals(currentEnemy.life, 4)
end

function testsAttackAndDefence:testNotRightSlot_NoDamage()
    player.playingCard = {action = actions.container['attack1']}
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.life = 5
    currentEnemy.slot = 3
    map.slots[1].card = {space = spaces.container.circle}

    player.playingCard.action:effect(player, currentEnemy)
    ResolutionState.calcDamage()

    luaunit.assertEquals(currentEnemy.life, 5)
end