function EnemyActionState:enter()
    print("enemy state")
    currentEnemy:playCard()
    GameState.switch(PlayerActionState)
end