NextEnemyState = {}

function NextEnemyState:enter()
    currentEnemyId = currentEnemyId + 1
    if currentEnemyId > #enemies then currentEnemyId = 1 end
    currentEnemy = enemies[currentEnemyId]
    currentEnemy:init()
    map:init()
    player:init()

    GameState.switch(EnemyActionState)
end