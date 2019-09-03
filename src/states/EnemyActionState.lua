EnemyActionState = {}

function EnemyActionState:enter()
    if currentEnemy:playCard() then
        currentEnemy:chooseActionSlot()
        print(currentEnemy.targetSlot)
    end
    GameState.switch(PlayerPlayCardState)
end