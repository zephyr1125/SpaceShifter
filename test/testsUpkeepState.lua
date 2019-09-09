testsUpkeepState = {}

function testsUpkeepState:testGraveyardRunOnUpkeep()
    GameState = {switch = function()end}
    player.life = 3
    player.slot = 1
    for _, slot in pairs(map.slots) do
        slot.card = {space = spaces.graveyard}
    end
    
    UpkeepState:enter()
    
    luaunit.assertEquals(player.life, 2)
end