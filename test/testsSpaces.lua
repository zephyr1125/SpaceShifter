testsSpaces = {}

function testsSpaces:setUp()
    GameState = {switch = function()end}
    ResolutionState:reset()
    player.slot = 1
    player.playingCardAsAction = true
end

function testsSpaces:tearDown()
    ResolutionState:reset()
end

function testsSpaces:testMountainAffectDefence()
    player.playingCard = {action = actions.container.move}
    player.targetSlot = 1
    map.slots[1].card = {space = spaces.container.mountain}
    currentEnemy.slot = 2
    map.slots[2].card = {space = spaces.container.mountain}
    ResolutionState.extraDefence()

    luaunit.assertEquals(player.defence, 1)
    luaunit.assertEquals(currentEnemy.defence, 1)
end

function testsSpaces:testPlainAffectAttack()
    player.playingCard = {action = actions.container.attack1}
    map.slots[1].card = {space = spaces.container.plain}
    player.playingCard.action.effect(player, currentEnemy)

    luaunit.assertEquals(player.attack, 2)
end

function testsSpaces:testGraveyardRunOnUpkeep()
    player.life = 3
    map.slots[1].card = {space = spaces.container.graveyard}

    UpkeepState:enter()

    luaunit.assertEquals(player.life, 2)
end

function testsSpaces:testGraveyard_ImmuneChar_Nothing()
    currentEnemy = enemies.cona
end

function testsSpaces:testCovePickCardOnDamaged()
    fillAllDecks()
    
    map.slots[1].card = {space = spaces.container.cove}
    map.slots[1].card = {space = spaces.container.cove}
    
    player.playingCard = {action = actions.container.move}
    player.life = 3
    player.targetSlot = 1
    player.currentCardId = 1
    player.hand = {player.playingCard}
    
    currentEnemy.playingCard = {action = actions.container.attack1}
    currentEnemy.targetSlot = 1
    currentEnemy.hand = {currentEnemy.playingCard, {action = actions.container.attack1}}

    ResolutionState:enter()

    luaunit.assertEquals(#player.hand, 1)
    luaunit.assertEquals(#currentEnemy.hand, 2)
end

function testsSpaces:testDesertDropCardOnAttack()
    map.slots[1].card = {space = spaces.container.desert}
    map.slots[2].card = {space = spaces.container.plain}

    player.playingCard = {action = actions.container.attack1}
    player.life = 3
    player.targetSlot = 2
    player.currentCardId = 1
    player.hand = {player.playingCard, {action = actions.container.attack1}}

    currentEnemy.playingCard = {action = actions.container.attack1}
    currentEnemy.targetSlot = 1
    currentEnemy.hand = {currentEnemy.playingCard, {action = actions.container.attack1}}

    ResolutionState:enter()

    luaunit.assertEquals(#player.hand, 1)
    luaunit.assertEquals(#currentEnemy.hand, 1)
end

function testsSpaces:testDesert_NotCorrectSlot_NoDropCard()
    map.slots[1].card = {space = spaces.container.desert}
    map.slots[2].card = {space = spaces.container.plain}

    player.playingCard = {action = actions.container.attack1}
    player.life = 3
    player.targetSlot = 3
    player.currentCardId = 1
    player.hand = {player.playingCard, {action = actions.container.attack1}}

    currentEnemy.playingCard = {action = actions.container.attack1}
    currentEnemy.targetSlot = 1
    currentEnemy.hand = {currentEnemy.playingCard, {action = actions.container.attack1}}

    ResolutionState:enter()

    luaunit.assertEquals(#player.hand, 1)
    luaunit.assertEquals(#currentEnemy.hand, 2)
end