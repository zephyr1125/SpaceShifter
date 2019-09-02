return {
    {
        name = '攻击1',
        icon = 'attack1',
        score = 1,
        needChooseSlot = true,
        effect = function(self, enemy)
            if self.targetSlot ~= enemy.slot then return end
            enemy.damagePending = enemy.damagePending + 1
        end,
    },{
        name = '防御1',
        icon = 'defence1',
        score = 1,
        needChooseSlot = false,
        effect = function(self, enemy)
            self.damagePending = self.damagePending - 1
        end,
    },
    {
        name = '治疗3',
        icon = 'heal3',
        score = 1,
        needChooseSlot = false,
        effect = function(self, enemy)
            self.life = self.life + 3
        end,
    },
    {
        -- heal3 and pick up 2 cards
        name = '神智清醒',
        icon = 'phoenix',
        score = 3,
        needChooseSlot = false,
        effect = function(self, enemy)
            self.life = self.life + 3
            self.drawCards(2)
        end,
    },{
        name = '移动',
        icon = 'move',
        score = 1,
        needChooseSlot = true,
        move = function(self)
            self.slot = self.targetSlot
        end,
    },
}