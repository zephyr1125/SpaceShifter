local function defaultTargetSlot(me, opponent)
    -- default to myself
    return me.slot
end

local Spaces = class {
    container = {
        ['mountain'] = {
            name = '山脉',
            icon = 'mountain',
            info = '提升1点防御',
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
            info = '提升2点防御',
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
            info = '提升1点攻击',
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
            info = '提升2点攻击',
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
            info = '提升1防御1攻击',
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
            info = '每回合受伤1',
            effectIcon = 'harm1',
            spaceAnim = 'graveyard',
            score = 2,
            benefit = -1,
            onUpkeep = function(resident)
                if resident ~= nil then
                    resident:changeLife(-1)
                end
            end,
            defaultTargetSlot = function(me, opponent)
                return defaultTargetSlot(me, opponent)
            end,
        },
        --['bog'] = {
        --    name = '沼泽',
        --    icon = 'bog',
        --    info = '无法转移时空',
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
            info = '受伤时抽牌1',
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
            info = '攻击时附加弃牌1',
            effectIcon = 'drop',
            spaceAnim = 'desert',
            score = 2,
            benefit = -1,
            onAttack = function(me, opponent)
                opponent:dropCard()
            end,
        },
    }
}
return Spaces