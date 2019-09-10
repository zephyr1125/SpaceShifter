local function defaultTargetSlot(me, opponent)
    -- default to myself
    return me.slot
end

return {
    ['mountain'] = {
        name = '山脉',
        icon = 'mountain',
        effectIcon = 'defence1',
        spaceAnim = 'mountain',
        score = 1,
        benefit = 1,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcDefence = function(me, opponent)
            -- if I am using defence, add 1 defence
            me.defence = me.defence + 1
        end
    },
    ['canyon'] = {
        name = '峡谷',
        icon = 'canyon',
        effectIcon = 'defence2',
        spaceAnim = 'canyon',
        score = 2,
        benefit = 2,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcDefence = function(me, opponent)
            -- if I am using defence, add 2 defence
            me.defence = me.defence + 2
        end
    },
    ['plain'] = {
        name = '平原',
        icon = 'plain',
        effectIcon = 'attack1',
        spaceAnim = 'plain',
        score = 1,
        benefit = 1,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcAttack = function(me, opponent)
            -- if I am using attack, add 1 attack
            me.attack = me.attack + 1
        end
    },
    ['ruin'] = {
        name = '遗迹',
        icon = 'ruin',
        effectIcon = 'attack2',
        spaceAnim = 'ruin',
        score = 2,
        benefit = 2,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcAttack = function(me, opponent)
            -- if I am using attack, add 2 attack
            me.attack = me.attack + 2
        end
    },
    ['castle'] = {
        name = '堡垒',
        icon = 'castle',
        effectIcon = 'a1d1',
        spaceAnim = 'castle',
        score = 2,
        benefit = 2,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcAttack = function(me, opponent)
            -- if I am using attack, add 1 attack
            me.attack = me.attack + 1
        end,
        onCalcDefence = function(me, opponent)
            -- if I am using defence, add 1 defence
            me.defence = me.defence + 1
        end
    },
    ['graveyard'] = {
        name = '墓地',
        icon = 'graveyard',
        effectIcon = 'harm1',
        spaceAnim = 'graveyard',
        score = 2,
        benefit = -1,
        onUpkeep = function(resident)
            if resident ~= nil then
                resident.life = resident.life -1
            end
        end,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
    },
    --['bog'] = {
    --    name = '沼泽',
    --    icon = 'bog',
    --    effectIcon = 'grounded',
    --    spaceAnim = 'bog',
    --    score = 2,
    --    benefit = -1,
    --    onActionCheck = function(action)
    --        if table.contains(action.type, 'move') then
    --            return false
    --        else
    --            return true
    --        end
    --    end,
    --},
    ['cove'] = {
        name = '海湾',
        icon = 'cove',
        effectIcon = 'pick',
        spaceAnim = 'cove',
        score = 2,
        benefit = 1,
        onDamaged = function(me)
            me:pickCard()
        end,
    },
    ['desert'] = {
        name = '沙漠',
        icon = 'desert',
        effectIcon = 'drop',
        spaceAnim = 'desert',
        score = 2,
        benefit = -1,
        onAttack = function(me, opponent)
            opponent:dropCard()
        end,
    },
}