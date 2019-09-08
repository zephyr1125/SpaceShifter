return {
    ['attack1'] = {
        name = '攻击1',
        icon = 'attack1',
        score = 1,
        needChooseSlot = true,
        effect = function(me, opponent)
            me.attack = me.attack + 1
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
        end,
        aiTargetSlot = function(me, opponent)
            -- default to opponent slot
            local neighbourId = map:isNeighbour(me.slot, opponent.slot)
            if neighbourId == 0 then
                -- opponent is not neighbour, target self
                return me.slot
            else
                return opponent.slot
            end
        end
    },
    ['defence1'] = {
        name = '防御1',
        icon = 'defence1',
        score = 1,
        needChooseSlot = false,
        effect = function(me, opponent)
            me.defence = me.defence + 1
        end,
    },
    --['hear1'] = {
    --    name = '治疗1',
    --    icon = 'heal1',
    --    score = 1,
    --    needChooseSlot = false,
    --    effect = function(me, opponent)
    --        me.life = me.life + 1
    --    end,
    --},
    ['concentrate'] = {
        -- heal1 and pick up 2 cards
        name = '集中精神',
        icon = 'concentrate',
        score = 3,
        needChooseSlot = false,
        effect = function(me, opponent)
            me.life = me.life + 1
            me.drawCards(2)
        end,
    },
    ['move'] = {
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
        end,
        aiTargetSlot = function(me, opponent)
            local neighbourId = map:isNeighbour(me.slot, opponent.slot)
            local myNeighbours = map:getNoHoleNeighbours(me.slot)
            if neighbourId == 0 then
                -- if opponent not neighbour, go to near opponent
                for _, slot in pairs(myNeighbours) do
                    if map:isNeighbour(slot, opponent.slot) ~= 0 then
                        return slot
                    end
                end
            else
                -- or find best slot, cant be opponent slot
                local mostBenefit = map.slots[me.slot].card.space.benefit
                local mostSlot = me.slot
                for _, slot in pairs(myNeighbours) do
                    local benefit = map.slots[slot].card.space.benefit
                    if benefit > mostBenefit and slot ~= opponent.slot then
                        mostBenefit = benefit
                        mostSlot = slot
                    end
                end
                if mostBenefit > me.slot then
                    return mostSlot
                end
            end
            return me.slot
        end
    },
}