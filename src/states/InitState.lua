InitState = {}

function InitState:enter()
    decks = reload('src.entities.Decks')
    player = reload('src.entities.Player')
    enemies = reload('src.entities.Enemies')
    currentEnemy = nil
    
    fillAllDecks()
    sortDeck(decks.PublicDeck)
    map:init(function()
        player:init(function()
            self:initEnemy(function()
                GameState.switch(EnemyActionState)
            end)
        end)
    end)
end

function InitState:initEnemy(onComplete)
    currentEnemyId = 'banshee'
    currentEnemy = enemies.container[currentEnemyId]
    currentEnemy:init(onComplete)
end

function InitState:update(dt)
    
end

function InitState:draw()
    
end