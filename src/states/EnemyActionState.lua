EnemyActionState = {}

function EnemyActionState:enter()
    cursor:setVisible(false)
    currentEnemy:playCard(player)
    GameState.switch(PlayerPlayCardState)
end