EnemyActionState = {}

function EnemyActionState:enter()
    if currentEnemy:playCard() then
        currentEnemy:chooseActionSlot()
    end
    GameState.switch(PlayerPlayCardState)
end