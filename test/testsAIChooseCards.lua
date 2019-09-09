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
end

function testsAIChooseCards:testLifeDanger_Heal()
    luaunit.assertEquals(baseAIChooseCard(self.me), 2)
end

function testsAIChooseCards:testPlayerNearby_Attack()
    self.me.life = 10
    luaunit.assertEquals(baseAIChooseCard(self.me, self.opponent), 1)
end

function testsAIChooseCards:testSpaceTooBad_Move()
    --self.me.life = 10
    --table.remove(self.me.hand, 1)
    --map.slots[1].card = {space = spaces.graveyard}
    --map.slots[2].card = {space = spaces.mountain}
    --map.slots[6].card = {space = spaces.plain}
    --map.slots[7].card = {space = spaces.graveyard}
    --luaunit.assertEquals(baseAIChooseCard(self.me, self.opponent), 4)
end