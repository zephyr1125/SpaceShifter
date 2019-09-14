local function defaultTargetSlot(me, opponent)
    -- default to myself
    return me.slot
end

local Spaces = class {
    container = {
        fence = {
            name = '栅栏',
            icon = imgFenceIcon,
            info = '提升1点防御',
            effectIcon = imgFenceEffect,
            chess = imgFenceChess,
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
            icon = imgCastleIcon,
            info = '提升2点防御',
            effectIcon = imgCastleEffect,
            chess = imgCastleChess,
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
            icon = imgCircleIcon,
            info = '提升1点攻击',
            effectIcon = imgCircleEffect,
            chess = imgCircleChess,
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
            icon = imgAdvCircleIcon,
            info = '提升2点攻击',
            effectIcon = imgAdvCircleEffect,
            chess = imgAdvCircleChess,
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
            icon = imgCircleFenceIcon,
            info = '提升1防御1攻击',
            effectIcon = imgCircleFenceEffect,
            chess = imgCircleFenceChess,
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
            icon = imgGraveyardIcon,
            info = '每回合受伤1',
            effectIcon = imgGraveyardEffect,
            chess = imgGraveyardChess,
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
        --    icon = 'bog',
        --    info = '无法转移时空',
        --    effectIcon = 'grounded',
        --    chess = 'bog',
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
        well = {
            name = '法力井',
            icon = imgWellIcon,
            info = '受伤时抽牌1',
            effectIcon = imgWellEffect,
            chess = imgWellChess,
            score = 2,
            benefit = 1,
            onDamaged = function(me)
                me:pickCard()
            end,
        },
        desert = {
            name = '沙漠',
            icon = imgDesertIcon,
            info = '攻击时附加弃牌1',
            effectIcon = imgDesertEffect,
            chess = imgDesertChess,
            score = 2,
            benefit = -1,
            onAttack = function(me, opponent)
                opponent:dropCard()
            end,
        },
    }
}
return Spaces