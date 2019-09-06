ResolutionState = {}

function ResolutionState:enter()
    self.reset()

    local playerAction = player.playingCard.action
    local playerSpace = player.playingCard.space
    local enemyAction = currentEnemy.playingCard.action
    local enemySpace = currentEnemy.playingCard.space

    -- both move first
    self.move(playerAction, enemyAction)
    self.cardsEffect(playerAction, enemyAction)
    self.extraDefence()
    self.calcDamage()
    self.changeSpace()
    
    self.cleanCards()
    -- next state
    GameState.switch(LifeCheckState)
end

function ResolutionState.move(playerAction, enemyAction)
    -- if they are moving to same slot, stop both
    if currentEnemy.playingCardAsAction and enemyAction.move ~= nil and
            player.playingCardAsAction and playerAction.move ~= nil and
            currentEnemy.targetSlot == player.targetSlot then
        -- todo play some collide animation
    else
        if currentEnemy.playingCardAsAction and enemyAction.move ~= nil then
            enemyAction.move(currentEnemy)
        end
        if player.playingCardAsAction and playerAction.move ~= nil then
            playerAction.move(player)
        end
    end
end

function ResolutionState.cardsEffect(playerAction, enemyAction)
    if player.playingCardAsAction and playerAction.effect ~= nil then
        playerAction.effect(player, currentEnemy)
    end
    if currentEnemy.playingCardAsAction and enemyAction.effect ~= nil then
        enemyAction.effect(currentEnemy, player)
    end
end

function ResolutionState.extraDefence()
    local playerAtSpace = map.slots[player.slot].card.space
    if playerAtSpace.onCalcDefence ~= nil then
        playerAtSpace.onCalcDefence(player, currentEnemy)
    end
    local enemyAtSpace = map.slots[currentEnemy.slot].card.space
    if enemyAtSpace.onCalcDefence ~= nil then
        enemyAtSpace.onCalcDefence(currentEnemy, player)
    end
end

function ResolutionState.calcDamage()
    -- no attack no damage
    if player.attack == 0 and currentEnemy.attack == 0 then return end

    -- not correct slot, no damage
    local isPlayerAttackSuccess =
        player.targetSlot ~= nil and player.targetSlot == currentEnemy.slot
    local isEnemyAttackSuccess =
        currentEnemy.targetSlot ~= nil and currentEnemy.targetSlot == player.slot
    
    -- calc damage
    if isPlayerAttackSuccess then
        currentEnemy.damagePending = player.attack - currentEnemy.defence
    end
    if isEnemyAttackSuccess then
        player.damagePending = currentEnemy.attack - player.defence
    end

    -- trim damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- resolve damage
    currentEnemy.life = currentEnemy.life - currentEnemy.damagePending
    player.life = player.life - player.damagePending
end

function ResolutionState.changeSpace()
    if player.playingCardAsAction then return end
    
    local oldCard = map.slots[player.targetSlot].card
    if oldCard ~= nil then
        discardCard(oldCard)
    end
    map.slots[player.targetSlot].card = player.playingCard
end

function ResolutionState.cleanCards()
    table.remove(player.hand, player.currentCardId)
    player.currentCardId = 0
    if player.playingCardAsAction then
        decks.PlayerDeck.discardCards[#decks.PlayerDeck.discardCards+1] = 
            player.playingCard
    end 
    player.playingCard = nil
    
    local enemyDeck = decks[currentEnemy.deck]
    enemyDeck.discardCards[#enemyDeck.discardCards+1] = currentEnemy.playingCard
    currentEnemy.playingCard = nil
end

function ResolutionState.reset()
    player.attack = 0
    player.defence = 0
    currentEnemy.attack = 0
    currentEnemy.defence = 0
    player.damagePending = 0
    currentEnemy.damagePending = 0
end