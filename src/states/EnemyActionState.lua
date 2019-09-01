function EnemyActionState:enter()
    currentEnemy:playCard()
    GameState.switch(PlayerPlayCardState)
end