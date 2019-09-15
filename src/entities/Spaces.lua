local function defaultTargetSlot(me, opponent)
    -- default to myself
    return me.slot
end

local Spaces = class {
    container = {
        fence = {
            name = '栅栏',
            info = i18n.infoFence,
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
        castle = {
            name = '城堡',
            info = i18n.infoCastle,
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
        circle = {
            name = '法阵',
            info = i18n.infoCircle,
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
        advCircle = {
            name = '上级法阵',
            info = i18n.infoAdvCircle,
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
        circleFence = {
            name = '防护法阵',
            info = i18n.infoCircleFence,
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
            info = i18n.infoGraveyard,
            score = 2,
            benefit = -1,
            onUpkeep = function(resident)
                if resident ~= nil and not resident.isImmuneGrave then
                    resident:changeLife(-1)
                end
            end,
            defaultTargetSlot = function(me, opponent)
                return defaultTargetSlot(me, opponent)
            end,
        },
        --['bog'] = {
        --    name = '沼泽',
        --    info = '无法转移时空',
        --    score = 2,
        --    benefit = -1,
        --    onActionCheck = function(action)
        --        if table.contains(action.type, 'move') then
        --            return false
        --        else
        --            return true
        --        end
        --    end,
        --    defaultTargetSlot = function(me, opponent)
        --        return defaultTargetSlot(me, opponent)
        --    end,
        --},
        well = {
            name = '法力井',
            info = i18n.infoWell,
            score = 2,
            benefit = 1,
            onDamaged = function(me)
                me:pickCard()
            end,
            defaultTargetSlot = function(me, opponent)
                return defaultTargetSlot(me, opponent)
            end,
        },
        desert = {
            name = '沙漠',
            info = infoDesert,
            score = 2,
            benefit = -1,
            onAttack = function(me, opponent)
                opponent:dropCard()
            end,
            defaultTargetSlot = function(me, opponent)
                return defaultTargetSlot(me, opponent)
            end,
        },
    }
}
return Spaces