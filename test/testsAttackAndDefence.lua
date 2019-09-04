testsAttackAndDefence = {}

function testsAttackAndDefence:tearDown()
    player.attack = 0
    player.defence = 0
    currentEnemy.attack = 0
    currentEnemy.defence = 0
    player.damagePending = 0
    currentEnemy.damagePending = 0
end

function testsAttackAndDefence:testPlainAffectAttack()
    player.playingCard = {action = actions[1]}
    player.playingCardAsAction = true
    player.slot = 1
    map.slots[1].card = {space = spaces['plain']}
    player.playingCard.action.effect(player, currentEnemy)
    
    luaunit.assertEquals(player.attack, 2)
end

function testsAttackAndDefence:testMountainAffectDefence()
    player.playingCard = {action = actions[2]}
    player.playingCardAsAction = true
    player.slot = 1
    map.slots[1].card = {space = spaces['mountain']}
    player.playingCard.action.effect(player, currentEnemy)

    luaunit.assertEquals(player.defence, 2)
end

function testsAttackAndDefence:testCorrectDamageCalc()
    
end

function testsAttackAndDefence:testNotRightSlot_NoDamage()
    
end