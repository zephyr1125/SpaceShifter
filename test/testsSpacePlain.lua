testsSpacePlain = {}

function testsSpacePlain:setUp()
    ResolutionState.reset()
end

function testsSpacePlain:tearDown()
    ResolutionState.reset()
end

function testsSpacePlain:testPlainAffectAttack()
    player.playingCard = {action = actions['attack1']}
    player.playingCardAsAction = true
    player.slot = 1
    map.slots[1].card = {space = spaces['plain']}
    player.playingCard.action.effect(player, currentEnemy)

    luaunit.assertEquals(player.attack, 2)
end