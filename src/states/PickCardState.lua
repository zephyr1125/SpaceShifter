PickCardState = {}

function PickCardState:enter()
    player:pickCard()
    currentEnemy:pickCard()
    GameState.switch(EnemyActionState)
end