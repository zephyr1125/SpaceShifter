LifeCheckState = {}

function LifeCheckState:enter()
    if player.life <= 0 and currentEnemy.life <= 0 then
        GameState.switch(BothDeathState)
    elseif player.life <= 0 then
        GameState.switch(LoseState)
    elseif currentEnemy.life <= 0 then
        GameState.switch(WinState)
    else
        GameState.switch(EnemyActionState)
    end
end