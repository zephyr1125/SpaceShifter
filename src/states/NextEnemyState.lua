NextEnemyState = {}

function NextEnemyState:enter()
    currentEnemy = randomElement(enemies.container, currentEnemy)
    currentEnemy:init()
    map:init()
    player:init()

    GameState.switch(EnemyActionState)
end