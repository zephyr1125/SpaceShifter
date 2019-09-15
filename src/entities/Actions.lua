local function baseDefaultTargetSlot(me, opponent)
    -- default to opponent slot
    local neighbourId = map:isNeighbour(me.slot, opponent.slot)
    if neighbourId == 0 then
        -- opponent is not neighbour, target self
        return me.slot
    else
        return opponent.slot
    end
end

local function playFireballSFX(me, opponent, sfx, onComplete)
    if sfx == nil then
        if onComplete~=nil then onComplete() end
        return
    else
        sfx.scale = 1
        sfx.x = me.x + me.spriteWidth/3
        sfx.y = me.y + me.spriteHeight/3
        soundFireballStart:play()
        timer.tween(0.6, sfx,
                {x = opponent.x+ opponent.spriteWidth/3, y = opponent.y + opponent.spriteHeight/3},
                'in-quart', function()
                    soundFireballHit:play()
                    if onComplete~=nil then onComplete() end
                end)
    end
end

local Actions = class {
    container = {
        ['attack1'] = {
            name = '戳刺',
            info = '对指定格上的单位攻击1',
            score = 1,
            needChooseSlot = true,
            type = {'attack'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 1
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['attack2'] = {
            name = '挥击',
            info = '对指定格上的单位攻击2',
            score = 2,
            needChooseSlot = true,
            type = {'attack'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 2
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['attack3'] = {
            name = '重劈',
            info = '对指定格上的单位攻击3',
            score = 3,
            needChooseSlot = true,
            type = {'attack'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 3
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['a1d1'] = {
            name = '格挡反击',
            info = '防御1并攻击1',
            score = 1.5,
            needChooseSlot = true,
            type = {'attack','defence'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 1
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                me.defence = me.defence + 1
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['a2d1'] = {
            name = '格挡重击',
            info = '防御1并攻击2',
            score = 2.5,
            needChooseSlot = true,
            type = {'attack','defence'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 2
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                me.defence = me.defence + 1
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['defence1'] = {
            name = '防御',
            info = '防御1点伤害',
            score = 1,
            needChooseSlot = false,
            type = {'defence'},
            effect = function(self, me, opponent, sfx, onComplete)
                me.defence = me.defence + 1
                if onComplete~=nil then onComplete() end
            end,
        },
        ['heal1'] = {
            name = '喘息',
            info = '提升1点血量',
            score = 1,
            needChooseSlot = false,
            type = {'heal'},
            effect = function(self, me, opponent, sfx, onComplete)
                me:changeLife(1)
                if onComplete~=nil then onComplete() end
            end,
        },
        ['heal2'] = {
            name = '包扎',
            info = '提升2点血量',
            score = 2.5,
            needChooseSlot = false,
            type = {'heal'},
            effect = function(self, me, opponent, sfx, onComplete)
                me:changeLife(2)
                if onComplete~=nil then onComplete() end
            end,
        },
        ['pick2'] = {
            -- pick up 2 cards
            name = '休整',
            info = '抓牌2',
            score = 3,
            needChooseSlot = false,
            type = {'pick'},
            effect = function(self, me, opponent, sfx, onComplete)
                me:pickCard()
                me:pickCard()
                if onComplete~=nil then onComplete() end
            end,
        },
        ['a1p1'] = {
            name = '戏法',
            info = '攻击1抓牌1',
            score = 2,
            needChooseSlot = true,
            type = {'attack','pick'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 1
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                me:pickCard()
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['a2p1'] = {
            name = '诈术',
            info = '攻击2抓牌1',
            score = 3,
            needChooseSlot = true,
            type = {'attack','pick'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 2
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                me:pickCard()
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['h1p2'] = {
            -- heal1 and pick up 2 cards
            name = '整理思绪',
            info = '加血1抓牌2',
            score = 3,
            needChooseSlot = false,
            type = {'heal','pick'},
            effect = function(self, me, opponent, sfx, onComplete)
                me:changeLife(1)
                me:pickCard()
                me:pickCard()
                if onComplete~=nil then onComplete() end
            end,
        },
        ['drop1'] = {
            name = '扰乱',
            info = '使指定格上的单位弃牌1张',
            score = 1.5,
            needChooseSlot = true,
            type = {'drop'},
            effect = function(self, me, opponent, sfx, onComplete)
                if me.targetSlot == opponent.slot then
                    opponent:dropCard()
                end
                if onComplete~=nil then onComplete() end
            end,
            getExceptSlot = function(me, opponent)
                -- can target anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['drop2'] = {
            name = '混乱',
            info = '使指定格上的单位弃牌2张',
            score = 2.5,
            needChooseSlot = true,
            type = {'drop'},
            effect = function(self, me, opponent, sfx, onComplete)
                if me.targetSlot == opponent.slot then
                    opponent:dropCard()
                    opponent:dropCard()
                end
                if onComplete~=nil then onComplete() end
            end,
            getExceptSlot = function(me, opponent)
                -- can target anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['a1drop1'] = {
            name = '摄魂一击',
            info = '对指定格上的单位攻击1弃牌1',
            score = 2,
            needChooseSlot = true,
            type = {'attack','drop'},
            sfxImg = imgSFXFireball,
            effect = function(self, me, opponent, sfx, onComplete)
                me.attack = me.attack + 1
                -- space affect attack
                local space = map.slots[me.slot].card.space
                if space.onCalcAttack ~= nil then
                    space.onCalcAttack(me, opponent)
                end
                if me.targetSlot == opponent.slot then
                    opponent:dropCard()
                end
                playFireballSFX(me, opponent, sfx, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['move'] = {
            name = '时空转移',
            info = '移动到另一个时空',
            score = 1,
            needChooseSlot = true,
            type = {'move'},
            move = function(me, onComplete)
                charMove(me, me.targetSlot, 'fly', onComplete)
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
        ['spaceRecover'] = {
            name = '时空复原',
            info = '目标时空恢复初始',
            score = 99,
            needChooseSlot = true,
            type = {'spaceRecover'},
            onShiftSpace = function(targetSlot, onComplete)
                map:shiftSpace(targetSlot, nil, onComplete)
            end,
            getExceptSlot = function(me, opponent)
                -- can attack anywhere
                return nil
            end,
            defaultTargetSlot = function(me, opponent)
                return baseDefaultTargetSlot(me, opponent)
            end
        },
        ['universeRecover'] = {
            name = '宇宙复原',
            info = '全部时空恢复初始',
            score = 99,
            needChooseSlot = false,
            type = {'spaceRecover'},
            onShiftSpace = function(targetSlot, onComplete)
                for i, _ in pairs(map.slots) do
                    local callback = (i == #map.slots) and onComplete or nil
                    map:shiftSpace(i, nil, callback)
                end
            end,
        },
        ['roundAttack'] = {
            name = '横扫',
            info = '每3回合对邻近所有格造成2伤害',
            score = 99,
            needChooseSlot = true,
            type = {'special'},
            sfxImg = imgSFXRoundAttack,
            effect = function(self, me, opponent, sfx, onComplete)
                for _, slot in pairs(map:getNoHoleNeighbours(me.slot)) do
                    local resident = map:getSlotOccupied(slot)
                        if resident ~= nil then
                        resident.damagePending = resident.damagePending + 3
                    end
                end
                if sfx == nil then
                    if onComplete~=nil then onComplete() end
                    return
                else
                    sfx.scale = 0.5
                    sfx.alpha = 1
                    sfx.x = me.x + me.spriteWidth/2 - 88 + sfx.scale * 88
                    sfx.y = me.y + me.spriteHeight - 24 + sfx.scale * 24
                    timer.tween(0.6, sfx,
                            {scale = 1.5, alpha = 0,
                             x = me.x + me.spriteWidth/2 - 88*1.5,
                             y = me.y + me.spriteHeight - 24*1.25},
                            'in-quart', function()
                                soundRoundAttack:play()
                                if onComplete~=nil then onComplete() end
                            end)
                end
            end,
        },
        ['graveWorld'] = {
            name = '千墓',
            info = '不受墓地影响,每3回合将所有地面变为墓地',
            score = 99,
            needChooseSlot = false,
            type = {'special'},
            onShiftSpace = function(targetSlot, onComplete)
                local needShift = {}
                for slotId, slot in pairs(map.slots) do
                    if slot.card.space ~= spaces.container.graveyard then
                        table.add(needShift, slotId)
                    end
                end
                for id, slotId in pairs(needShift) do
                    local slot = map.slots[slotsId]
                    local card = Card(nil, spaces.container.graveyard)
                    card.isShowAction = false
                    local callback = (id == #needShift) and onComplete or nil
                    map:shiftSpace(slotId, card, callback)
                end
            end,
        },
        ['jump'] = {
            name = '千斤坠',
            info = '每3回合跳跃到玩家位置,造成3点伤害并击退',
            score = 99,
            needChooseSlot = false,
            type = {'special'},
            effect = function(self, me, opponent, sfx, onComplete)
                -- jump to me.targetSlot
                charMove(me, me.targetSlot, 'jump', function()
                    soundHit2:play()
                    -- if opponent still there, cause damage and bounce away
                    if opponent.slot == me.targetSlot then
                        opponent.damagePending = opponent.damagePending + 3
                        charMove(opponent, randomElement(map:getNoHoleNeighbours(opponent.slot)),
                                'hit', onComplete)
                    else
                        if onComplete~=nil then onComplete() end
                    end
                end)
            end,
        },
    }
}
return Actions