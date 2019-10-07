InitState = {}

function InitState:enter()
    isTutorialPlayed = false
    isEnemyShowed = false
    cursor:setVisible(false)
    -- Game Data
    actions = reload('src.entities.Actions')
    for key, action in pairs(actions.container) do
        action.effectIcon = love.graphics.newImage('assets/images/action_effect/'..key..'.png')
        action.icon = love.graphics.newImage('assets/images/action_icon/'..key..'.png')
    end

    spaces =  reload('src.entities.Spaces')
    for key, space in pairs(spaces.container) do
        space.icon = love.graphics.newImage('assets/images/space_icon/'..key..'.png')
        space.effectIcon = love.graphics.newImage('assets/images/space_effect/'..key..'.png')
        space.chess = love.graphics.newImage('assets/images/space_chess/'..key..'.png')
    end
    
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