testsBanshee = {}

function testsBanshee:setUp()
    fillAllDecks()
    player.slot = 1
    player.playingCard = Card(actions.container.move)
    player.targetSlot = 1
    
    currentEnemy = enemies.container.banshee
    currentEnemy:init()
    currentEnemy.slot = 2
    currentEnemy.hand = {Card(actions.container.move)}
    currentEnemy.targetSlot = 2
end

function testsBanshee:testSpecialAttack()
    currentEnemy:playCard(player)
    ResolutionState:reset()
    ResolutionState:cardsEffect(player.playingCard.action, currentEnemy.playingCard.action)
    luaunit.assertEquals(currentEnemy.specialCounter, 1)
    luaunit.assertNotEquals(player.damagePending, 3)
    
    currentEnemy:playCard(player)
    ResolutionState:reset()
    ResolutionState:cardsEffect(player.playingCard.action, currentEnemy.playingCard.action)
    luaunit.assertEquals(currentEnemy.specialCounter, 2)
    luaunit.assertNotEquals(player.damagePending, 3)
    
    currentEnemy:playCard(player)
    ResolutionState:reset()
    ResolutionState:cardsEffect(player.playingCard.action, currentEnemy.playingCard.action)
    luaunit.assertEquals(currentEnemy.specialCounter, 0)
    luaunit.assertEquals(player.damagePending, 3)
end