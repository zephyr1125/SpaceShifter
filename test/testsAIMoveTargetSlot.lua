testsAIMoveTargetSlot = {}

function testsAIMoveTargetSlot:setUp()
    currentEnemy = enemies[1]
end

function testsAIMoveTargetSlot:tearDown()
    currentEnemy = nil
end

function testsAIMoveTargetSlot:testMoveTocurrentEnemyNeighbour()
    player.slot = 1
    currentEnemy.slot = 4
    local target = actions['move'].aiTargetSlot(player, currentEnemy)
    luaunit.assertNotEquals(map:isNeighbour(target, 4),  0)
end