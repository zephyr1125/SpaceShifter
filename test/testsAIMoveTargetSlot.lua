testsAIMoveTargetSlot = {}

function testsAIMoveTargetSlot:testMoveToOpponentNeighbour()
    local me, opponent = {},{}
    me.slot = 1
    opponent.slot = 4
    local target = actions['move'].aiTargetSlot(me, opponent)
    luaunit.assertNotEquals(map:isNeighbour(target, 4),  0)
end

function testsAIMoveTargetSlot:testMoveToMostBenefitSlot()
    local me, opponent = {},{}
    me.slot = 1
    opponent.slot = 2
    map.slots[1].card = {space = {benefit = 1}}
    map.slots[2].card = {space = {benefit = -1}}
    map.slots[7].card = {space = {benefit = 2}}
    map.slots[6].card = {space = {benefit = 4}}
    local target = actions['move'].aiTargetSlot(me, opponent)
    luaunit.assertEquals(target,  6)
end

function testsAIMoveTargetSlot:testDontMoveToOpponentSlot()
    local me, opponent = {},{}
    me.slot = 1
    opponent.slot = 2
    map.slots[1].card = {space = {benefit = 1}}
    map.slots[2].card = {space = {benefit = 4}}
    map.slots[7].card = {space = {benefit = 2}}
    map.slots[6].card = {space = {benefit = 1}}
    local target = actions['move'].aiTargetSlot(me, opponent)
    luaunit.assertEquals(target,  7)
end