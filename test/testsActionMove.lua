require('src.states/ResolutionState')
testsActionMove = {}

function testsActionMove:setUp()
    currentEnemy = enemies[1]
    player.slot = 1
    currentEnemy.slot = 7
end

function testsActionMove:testMove()
    player.playingCard = {action = actions[5]}
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.playingCard = {action = actions[5]}
    currentEnemy.playingCardAsAction = true
    currentEnemy.targetSlot = 5

    ResolutionState.move(player.playingCard.action, currentEnemy.playingCard.action)

    luaunit.assertEquals(player.slot, 2)
    luaunit.assertEquals(currentEnemy.slot, 5)
end

function testsActionMove:testIfBothSameTarget_NeitherMove()
    player.playingCard = {action = actions[5]}
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.playingCard = {action = actions[5]}
    currentEnemy.playingCardAsAction = true
    currentEnemy.targetSlot = 2
    
    ResolutionState.move(player.playingCard.action, currentEnemy.playingCard.action)
    
    luaunit.assertEquals(player.slot, 1)
    luaunit.assertEquals(currentEnemy.slot, 7)
end