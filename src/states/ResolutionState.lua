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
    self.onAttack()
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

function ResolutionState.onAttack()
    if table.contains(player.playingCard.action.type, 'attack') then
        local isHit = player.targetSlot == currentEnemy.slot
        local space = map.slots[player.slot].card.space
        if isHit and space.onAttack~= nil then space.onAttack(player, currentEnemy) end
    end

    if table.contains(currentEnemy.playingCard.action.type, 'attack') then
        local isHit = currentEnemy.targetSlot == player.slot
        local space = map.slots[currentEnemy.slot].card.space
        if isHit and space.onAttack~= nil then space.onAttack(currentEnemy, player) end
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
        currentEnemy.damagePending = currentEnemy.damagePending + player.attack
        currentEnemy.damagePending = currentEnemy.damagePending - currentEnemy.defence
    end
    if isEnemyAttackSuccess then
        player.damagePending = player.damagePending + currentEnemy.attack
        player.damagePending = player.damagePending - player.defence
    end

    -- trim damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- space onDamaged
    local enemySpace = map.slots[currentEnemy.slot].card.space
    if currentEnemy.damagePending > 0 and enemySpace.onDamaged ~= nil then
        enemySpace.onDamaged(currentEnemy)
    end
    local playerSpace = map.slots[player.slot].card.space
    if player.damagePending > 0 and playerSpace.onDamaged ~= nil then
        playerSpace.onDamaged(player)
    end

    -- resolve damage
    currentEnemy.life = currentEnemy.life - currentEnemy.damagePending
    player.life = player.life - player.damagePending
end

function ResolutionState.changeSpace()
    local enemyChangeSpace = currentEnemy.playingCard.action.onChangeSpace
    if enemyChangeSpace ~= nil then
        enemyChangeSpace(currentEnemy.targetSlot)
    end
    
    if player.playingCardAsAction then return end
    
    map:changeSpace(player.targetSlot, player.playingCard)
end

function ResolutionState.cleanCards()
    table.remove(player.hand, player.currentCardId)
    player.currentCardId = 0
    if player.playingCardAsAction then
        table.add(decks.PlayerDeck.discardCards, player.playingCard)
    end 
    player.playingCard = nil

    if not currentEnemy.isPlayingSpecialCard then
        local enemyDeck = decks[currentEnemy.deck]
        table.add(enemyDeck.discardCards, currentEnemy.playingCard)
    end
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