testsAttackAndDefence = {}

function testsAttackAndDefence:setUp()
    ResolutionState:reset()
end

function testsAttackAndDefence:tearDown()
    ResolutionState:reset()
end

function testsAttackAndDefence:testPlainAffectAttack()
    player.playingCard = {action = actions.container['attack1']}
    player.playingCardAsAction = true
    player.slot = 1
    map.slots[1].card = {space = spaces.container['plain']}
    player.playingCard.action.effect(player, currentEnemy)
    
    luaunit.assertEquals(player.attack, 2)
end

function testsAttackAndDefence:testMountainAffectDefence()
    player.playingCard = {action = actions.container['move']}
    player.playingCardAsAction = true
    player.slot = 1
    player.targetSlot = 1
    map.slots[1].card = {space = spaces.container['mountain']}
    currentEnemy.slot = 2
    map.slots[2].card = {space = spaces.container['mountain']}
    ResolutionState.extraDefence()

    luaunit.assertEquals(player.defence, 1)
    luaunit.assertEquals(currentEnemy.defence, 1)
end

function testsAttackAndDefence:testCorrectDamageCalc()
    player.playingCard = {action = actions.container['attack1']}
    player.playingCardAsAction = true
    player.slot = 1
    player.targetSlot = 2
    currentEnemy.life = 5
    currentEnemy.defence = 1
    currentEnemy.slot = 2
    map.slots[1].card = {space = spaces.container['plain']}

    player.playingCard.action.effect(player, currentEnemy)
    ResolutionState.calcDamage()
    
    luaunit.assertEquals(currentEnemy.life, 4)
end

function testsAttackAndDefence:testNotRightSlot_NoDamage()
    player.playingCard = {action = actions.container['attack1']}
    player.playingCardAsAction = true
    player.slot = 1
    player.targetSlot = 2
    currentEnemy.life = 5
    currentEnemy.slot = 3
    map.slots[1].card = {space = spaces.container['plain']}

    player.playingCard.action.effect(player, currentEnemy)
    ResolutionState.calcDamage()

    luaunit.assertEquals(currentEnemy.life, 5)
end