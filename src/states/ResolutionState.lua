ResolutionState = {}

function ResolutionState:enter()
    ResolutionState:reset()

    local enemyAction = currentEnemy.playingCard.action
    local enemySpace = currentEnemy.playingCard.space
    local playerAction = player.playingCard.action
    local playerSpace = player.playingCard.space
    
    -- both move actions first
    if currentEnemy.playingCardAsAction and enemyAction.move ~= nil then
        enemyAction.move(currentEnemy)
    end
    if player.playingCardAsAction and playerAction.move ~= nil then
        playerAction.move(player)
    end
    
    -- both actions take effect
    if currentEnemy.playingCardAsAction and enemyAction.effect ~= nil then
        enemyAction.effect(currentEnemy, player)
    end
    if player.playingCardAsAction and playerAction.effect ~= nil then
        playerAction.effect(player, currentEnemy)
    end

    -- trim damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- resolve damage
    currentEnemy.life = currentEnemy.life - currentEnemy.damagePending
    player.life = player.life - player.damagePending
    
    --clean cards
    GameState.cleanCards()
    -- next state
    GameState.switch(LifeCheckState)
end

function ResolutionState.cleanCards()
    table.remove(player.hand, player.currentCardId)
    player.currentCardId = 0
    player.playingCard = nil
    
    currentEnemy.playingCard = nil
end

function ResolutionState:reset()
    currentEnemy.damagePending = 0
    player.damagePending = 0
end