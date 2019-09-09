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
        onCountDefence = function()
            return 1
        end,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcDefence = function(me, opponent)
            -- if I am using defence, add 1 defence
            me.defence = me.defence + 1
        end
    },
    ['plain'] = {
        name = '平原',
        icon = 'plain',
        effectIcon = 'attack1',
        spaceAnim = 'plain',
        score = 1,
        benefit = 1,
        onCalcAttack = function()
            return 1
        end,
        defaultTargetSlot = function(me, opponent)
            return defaultTargetSlot(me, opponent)
        end,
        onCalcAttack = function(me, opponent)
            -- if I am using attack, add 1 attack
            me.attack = me.attack + 1
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
    }
    
}