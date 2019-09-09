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

function testsAIMoveTargetSlot:testMoveToMostBenefitSlot()
    player.slot = 1
    currentEnemy.slot = 2
    map.slots[1].card = {space = {benefit = 1}}
    map.slots[2].card = {space = {benefit = -1}}
    map.slots[7].card = {space = {benefit = 2}}
    map.slots[6].card = {space = {benefit = 4}}
    local target = actions['move'].aiTargetSlot(player, currentEnemy)
    luaunit.assertEquals(target,  6)
end

function testsAIMoveTargetSlot:testDontMoveTocurrentEnemySlot()
    player.slot = 1
    currentEnemy.slot = 2
    map.slots[1].card = {space = {benefit = 1}}
    map.slots[2].card = {space = {benefit = 4}}
    map.slots[7].card = {space = {benefit = 2}}
    map.slots[6].card = {space = {benefit = 1}}
    local target = actions['move'].aiTargetSlot(player, currentEnemy)
    luaunit.assertEquals(target,  7)
end