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
    currentEnemy.isInited = false
    player.x = 0
    player.y = -120
    currentEnemy.x = 0
    currentEnemy.y = -120
    map:init(function()
        player:init(function()
            currentEnemy:init(function()
                GameState.switch(EnemyActionState)
            end)
        end)
    end)
end