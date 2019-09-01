function ResolutionState:enter()
    ResolutionState:reset()

    -- both actions take effect
    if currentEnemy.playingCardAsAction then
        currentEnemy.playingCard.action.effect(currentEnemy, player)
    end
    if player.playingCardAsAction then
        player.playingCard.action.effect(player, currentEnemy)
    end

    -- calc damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- resolve damage
    currentEnemy.life = currentEnemy.life - currentEnemy.damagePending
    player.life = player.life - player.damagePending

    -- both spaces take effect
end

function ResolutionState:reset()
    currentEnemy.damagePending = 0
    player.damagePending = 0
end