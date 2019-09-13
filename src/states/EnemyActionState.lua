EnemyActionState = {}

function EnemyActionState:enter()
    currentEnemy:playCard(player)
    GameState.switch(PlayerPlayCardState)
end