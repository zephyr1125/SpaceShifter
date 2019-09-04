return {
    {
        name = '攻击1',
        icon = 'attack1',
        score = 1,
        needChooseSlot = true,
        effect = function(me, opponent)
            me.attack = 1
            -- space affect attack
            local space = map.slots[me.slot].card.space
            if space.onCalcAttack ~= nil then
                space.onCalcAttack(me, opponent)
            end
        end,
        getExceptSlot = function(me, opponent)
            -- can attack anywhere
            return nil
        end,
        defaultTargetSlot = function(me, opponent)
            -- default to opponent slot
            local neighbourId = map:isNeighbour(me.slot, opponent.slot)
            if neighbourId == 0 then
                -- opponent is not neighbour, target self
                return me.slot
            else
                return opponent.slot
            end
        end
    },{
        name = '防御1',
        icon = 'defence1',
        score = 1,
        needChooseSlot = false,
        effect = function(me, opponent)
            me.defence = 1
            -- space affect defence
            local space = map.slots[me.slot].card.space
            if space.onCalcDefence ~= nil then
                space.onCalcDefence(me, opponent)
            end
        end,
    },
    {
        name = '治疗1',
        icon = 'heal1',
        score = 1,
        needChooseSlot = false,
        effect = function(me, opponent)
            me.life = me.life + 1
        end,
    },
    {
        -- heal1 and pick up 2 cards
        name = '神智清醒',
        icon = 'phoenix',
        score = 3,
        needChooseSlot = false,
        effect = function(me, opponent)
            me.life = me.life + 1
            me.drawCards(2)
        end,
    },{
        name = '移动',
        icon = 'move',
        score = 1,
        needChooseSlot = true,
        move = function(me)
            me.slot = me.targetSlot
        end,
        getExceptSlot = function(me, opponent)
            -- cant move to enemy slot
            return opponent.slot
        end,
        defaultTargetSlot = function(me, opponent)
            -- due to performance, default to self
            return me.slot
        end
    },
}