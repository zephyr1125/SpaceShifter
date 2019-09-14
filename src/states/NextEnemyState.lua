NextEnemyState = {}

function NextEnemyState:enter()
    if currentEnemyId == 'banshee' then
        currentEnemyId = 'ghost'
    elseif currentEnemyId == 'ghost' then
        currentEnemyId = 'troll'
    elseif currentEnemyId == 'troll' then
        currentEnemyId = 'banshee'    
    end
    currentEnemy = enemies.container[currentEnemyId]
    currentEnemy:init()
    map:init()
    player:init()

    GameState.switch(EnemyActionState)
end