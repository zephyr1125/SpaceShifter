testsAIChooseCards = {}

function testsAIChooseCards:setUp()
    self.me = {}
    self.me.life = 2
    self.me.initLife = 10
    self.me.hand = {
        {action=actions.attack1},
        {action=actions.heal1},
        {action=actions.defence1},
        {action=actions.move}}
    self.me.slot = 1
    
    self.opponent = {}
    self.opponent.slot = 2
    currentEnemy = self.opponent
end

function testsAIChooseCards:teatDown()
    currentEnemy = nil
end

function testsAIChooseCards:testLifeDanger_Heal()
    luaunit.assertEquals(baseAIChooseCard(self.me), 2)
end

function testsAIChooseCards:testPlayerNearby_Attack()
    self.me.life = 10
    local cardId, targetSlot = baseAIChooseCard(self.me, self.opponent)
    luaunit.assertEquals(cardId, 1)
    luaunit.assertEquals(targetSlot, 2)
end

function testsAIChooseCards:testPlayerToFar_Move()
    self.me.life = 10
    self.opponent.slot = 3
    local cardId, targetSlot = baseAIChooseCard(self.me, self.opponent)
    luaunit.assertEquals(cardId, 4)
    luaunit.assertEquals(targetSlot, 2)
end

function testsAIChooseCards:testSpaceTooBad_Move()
    self.me.life = 10
    table.remove(self.me.hand, 1)
    map.slots[1].card = {space = {benefit = 1}}
    map.slots[2].card = {space = {benefit = 4}}
    map.slots[6].card = {space = {benefit = 2}}
    map.slots[7].card = {space = {benefit = 1}}
    local cardId, targetSlot = baseAIChooseCard(self.me, self.opponent)
    luaunit.assertEquals(cardId, 3)
    luaunit.assertEquals(targetSlot, 6)
end