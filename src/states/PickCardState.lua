PickCardState = {}

function PickCardState:enter()
    cursor:setVisible(false)
    player:pickCard()
    currentEnemy:pickCard()
    GameState.switch(EnemyActionState)
end