testsActions = {}

function testsActions:setUp()
    GameState = {switch = function()end}
    currentEnemy = enemies[1]
    player.slot = 1
    currentEnemy.slot = 7
end

function testsActions:testMove()
    player.playingCard = {action = actions['move']}
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.playingCard = {action = actions['move']}
    currentEnemy.playingCardAsAction = true
    currentEnemy.targetSlot = 5

    ResolutionState.move(player.playingCard.action, currentEnemy.playingCard.action)

    luaunit.assertEquals(player.slot, 2)
    luaunit.assertEquals(currentEnemy.slot, 5)
end

function testsActions:testIfBothSameTarget_NeitherMove()
    player.playingCard = {action = actions['move']}
    player.playingCardAsAction = true
    player.targetSlot = 2
    currentEnemy.playingCard = {action = actions['move']}
    currentEnemy.playingCardAsAction = true
    currentEnemy.targetSlot = 2
    
    ResolutionState.move(player.playingCard.action, currentEnemy.playingCard.action)
    
    luaunit.assertEquals(player.slot, 1)
    luaunit.assertEquals(currentEnemy.slot, 7)
end

function testsActions:testDropCard()
    local playerPlayingCard = {action = actions.drop1}
    player.playingCard = playerPlayingCard
    player.currentCardId = 1
    player.playingCardAsAction = true
    player.targetSlot = 7
    player.hand = {playerPlayingCard, {action=actions.attack1}}

    local enemyPlayingCard = {action = actions.move}
    currentEnemy.playingCard = enemyPlayingCard
    currentEnemy.currentCardId = 1
    currentEnemy.targetSlot = 7
    currentEnemy.hand = {{action=actions.attack1}, {action=actions.attack1}
        ,enemyPlayingCard}

    ResolutionState:enter()

    luaunit.assertEquals(#currentEnemy.hand, 2)
end

function testsActions:testDropCard_NotSecondCardWhenFirstIsPlayingCard()
    local playerPlayingCard = {action = actions.drop1}
    player.playingCard = playerPlayingCard
    player.currentCardId = 1
    player.playingCardAsAction = true
    player.targetSlot = 7
    player.hand = {playerPlayingCard, {action=actions.attack1}}

    local enemyPlayingCard = {action = actions.move}
    currentEnemy.playingCard = enemyPlayingCard
    currentEnemy.currentCardId = 1
    currentEnemy.targetSlot = 7
    currentEnemy.hand = {enemyPlayingCard, {action=actions.attack1}}

    ResolutionState:enter()
    luaunit.assertEquals(#currentEnemy.hand, 1)
    luaunit.assertEquals(currentEnemy.hand[1], enemyPlayingCard)
end

function testsActions:testDropCard_NotDropPlayingCardWhenOnly()
    local playerPlayingCard = {action = actions.drop1}
    player.playingCard = playerPlayingCard
    player.currentCardId = 1
    player.playingCardAsAction = true
    player.targetSlot = 7
    player.hand = {playerPlayingCard, {action=actions.attack1}}

    local enemyPlayingCard = {action = actions.move}
    currentEnemy.playingCard = enemyPlayingCard
    currentEnemy.currentCardId = 1
    currentEnemy.targetSlot = 7
    currentEnemy.hand = {enemyPlayingCard}

    ResolutionState:enter()
    luaunit.assertEquals(#currentEnemy.hand, 1)
end

function testsActions:testDropCard_MissSlot_NotDrop()
    local playerPlayingCard = {action = actions.drop1}
    player.playingCard = playerPlayingCard
    player.currentCardId = 1
    player.playingCardAsAction = true
    player.targetSlot = 2
    player.hand = {playerPlayingCard, {action=actions.attack1}}
    
    local enemyPlayingCard = {action = actions.move}
    currentEnemy.playingCard = enemyPlayingCard
    currentEnemy.currentCardId = 1
    currentEnemy.targetSlot = 7
    currentEnemy.hand = {enemyPlayingCard, {action=actions.attack1}}
    
    ResolutionState:enter()
    luaunit.assertEquals(#currentEnemy.hand, 2)
end