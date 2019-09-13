InitState = {}

function InitState:enter()
    decks = reload('src.entities.Decks')
    player = reload('src.entities.Player')
    enemies = reload('src.entities.Enemies')
    
    fillAllDecks()
    sortDeck(decks.PublicDeck)
    map:init()
    player:init()
    self:initEnemy()
    
    GameState.switch(EnemyActionState)
end

function InitState:initEnemy()
    currentEnemy = enemies.container.ghost
    currentEnemy:init()
end

function InitState:update(dt)
    
end

function InitState:draw()
    
end