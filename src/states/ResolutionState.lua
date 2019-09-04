ResolutionState = {}

function ResolutionState:enter()
    ResolutionState:reset()

    local enemyAction = currentEnemy.playingCard.action
    local enemySpace = currentEnemy.playingCard.space
    local playerAction = player.playingCard.action
    local playerSpace = player.playingCard.space

    -- both move first
    self.move(playerAction, enemyAction)
    
    -- both actions take effect
    if currentEnemy.playingCardAsAction and enemyAction.effect ~= nil then
        enemyAction.effect(currentEnemy, player)
    end
    if player.playingCardAsAction and playerAction.effect ~= nil then
        playerAction.effect(player, currentEnemy)
    end

    -- calc damage
    
    -- trim damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- resolve damage
    currentEnemy.life = currentEnemy.life - currentEnemy.damagePending
    player.life = player.life - player.damagePending
    
    --clean cards
    ResolutionState.cleanCards()
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

function ResolutionState.cleanCards()
    table.remove(player.hand, player.currentCardId)
    player.currentCardId = 0
    decks.PlayerDeck.discardCards[#decks.PlayerDeck.discardCards+1] = player.playingCard
    player.playingCard = nil
    
    local enemyDeck = decks[currentEnemy.deck]
    enemyDeck.discardCards[#enemyDeck.discardCards+1] = currentEnemy.playingCard
    currentEnemy.playingCard = nil
end

function ResolutionState:reset()
    player.attack = 0
    player.defence = 0
    currentEnemy.attack = 0
    currentEnemy.defence = 0
    player.damagePending = 0
    currentEnemy.damagePending = 0
end