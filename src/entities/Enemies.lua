local function baseInit(self, deck, onComplete)
    self.life = player.life
    self.slot = 7
    charMove(self, self.slot, 'arrive', function()
        self.hand = deck:pickCards(self.handSize)
        self.specialCounter = 0
        self.isInited = true
        onComplete()
    end)
end

local baseDrawInfo = function(self, x, y)
    -- specialCard
    self.specialCard:draw()
    
    setColor(white)
    love.graphics.draw(imgEnemyFrame, x, y)
    
    -- connector
    love.graphics.draw(imgConnectionEnemyFrame, x-3, y+18)

    --portrait
    love.graphics.draw(self.portrait, x+6, y+4)

    --name
    love.graphics.printf(self.name, x, y+32, 50, 'center')

    --life--
    love.graphics.draw(imgHealTip, x-6, y)
    love.graphics.setFont(fontNum)
    love.graphics.printf(tostring(self.life), x-6, y+2, 19, 'center')
    love.graphics.setFont(fontCN)
end

function baseAIChooseCard(me, opponent)
    local cardId = 0
    local targetSlot = 0

    -- life low, heal
    if cardId == 0 and getLifePercent(me) < 0.3 then
        print('ai choose heal')
        cardId = chooseHandCardHeal(me)
    end

    -- player hand too much, drop
    if cardId == 0 and map:isNeighbour(me.slot, opponent.slot)~=0 and #opponent.hand >3 then
        print('ai choose drop')
        cardId = chooseHandCardDrop(me)
        targetSlot = opponent.slot
    end
    
    -- player nearby, attack
    if cardId == 0 and map:isNeighbour(me.slot, opponent.slot)~=0 then
        print('ai choose attack')
        cardId = chooseHandCardAttack(me)
        targetSlot = opponent.slot
    end
    
    -- player too far, move
    if cardId == 0 and map:isNeighbour(me.slot, opponent.slot) == 0 then
        local myNeighbours = map:getNoHoleNeighbours(me.slot)
        -- go to near opponent
        print('ai choose approach player')
        cardId = chooseHandCardMove(me)
        for _, slot in pairs(myNeighbours) do
            if map:isNeighbour(slot, opponent.slot) ~= 0 then
                targetSlot = slot
                break
            end
        end
    end

    -- space too bad, clean space
    if cardId == 0 then
        local meSlot = map.slots[me.slot]
        if meSlot.card~=meSlot.baseCard and meSlot.card.space.benefit<0 then
            cardId = chooseHandCardSpaceRecover(me)
            if cardId > 0 then print('ai choose space recover self') end
            targetSlot = me.slot
        end
    end

    -- player space too good, clean space
    if cardId == 0 then
        local opponentSlot = map.slots[opponent.slot]
        if map:isNeighbour(me.slot, opponent.slot)~=0 and
                opponentSlot.card ~= opponent.baseCard and
                opponentSlot.card.space.benefit>1 then
            cardId = chooseHandCardSpaceRecover(me)
            if cardId > 0 then print('ai choose space recover player') end
            targetSlot = opponent.slot
        end
    end
    
    -- space too bad, move to best neighbour
    if cardId == 0 then
        local bestBenefitSlot = map:getBestBenefitNeighbour(me.slot)
        if bestBenefitSlot ~= me.slot and map:isNeighbour(bestBenefitSlot, opponent.slot) == 0 then
            print('ai choose move to better slot')
            cardId = chooseHandCardMove(me)
            targetSlot = bestBenefitSlot
        end
    end
    
    -- others, just random a card 
    if cardId == 0 then
        print('ai choose random')
        cardId = random(#me.hand)
        targetSlot = me.slot
    end
    
    return cardId, targetSlot
end

local basePlayCard = function(self)
    if self.hand == nil or #self.hand == 0 then return end
    local cardId, targetSlot = baseAIChooseCard(self, player)
    self.playingCard = table.remove(self.hand, cardId)
    self.playingCardAsAction = true
    self.targetSlot = targetSlot
    self.playingCard:moveTo(enemyCardX, enemyCardY, 0.2)
end

local baseDrawPlayingCard = function(self)
    if(self.playingCard ~= nil) then
        self.playingCard:draw()
    end
end

local baseDrawSprite = function(self, imageSprite, mapX, mapY)
    local shakeX = 0
    if self.isShaking then
        shakeX = love.math.random(-2, 2)
    end
    setColor(white)
    love.graphics.draw(imageSprite, mapX + self.x + shakeX, mapY + self.y)

    -- draw tips
    drawTip(self, self.damageTip)
    drawTip(self, self.healTip)
end

local baseChooseActionSlot = function(self, action)
    self.targetSlot = action.aiTargetSlot(self, player)
end

local Enemies = class {
    container = {
        banshee = {
            name = '巨蛇',
            portrait = imgBansheePortrait,
            initLife = 5,
            deck = 'BansheeDeck',
            handSize = 3,
            spriteWidth = 42,
            spriteHeight = 41,
            isShaking = false,
            isInited = false,
            x = 0,
            y = -120,
            specialCard = Card(actions.container.roundAttack, nil, specialCardX, specialCardY),
            damageTip = {x = -4, baseY = -4, y = -4, img = imgDamageTip, value = 0},
            healTip = {x = 16, baseY = -4, y = -4, img = imgHealTip, value = 0},
            init = function(self, onComplete)
                baseInit(self, decks.BansheeDeck, onComplete)
            end,
            drawInfo = function(self, x, y)
                baseDrawInfo(self, x, y)
            end,
            drawPlayingCard = function(self)
                baseDrawPlayingCard(self)
            end,
            drawSprite = function(self, mapX, mapY)
                baseDrawSprite(self, imgBansheeSprite, mapX, mapY)
            end,
            drawSelectSlot = function(self)
                if self.targetSlot == nil or self.targetSlot == 0 then return end

                local slot = map.slots[self.targetSlot]
                setColor(red)
                love.graphics.draw(imgSlotSelect, mapX + slot.x, mapY + slot.y)
            end,
            playCard = function(me, opponent)
                me.isPlayingSpecialCard = false
                me.specialCounter = me.specialCounter+1
                if me.specialCounter >= 3 then
                    me.specialCounter = 0
                    me.isPlayingSpecialCard = true
                    me.playingCard = me.specialCard
                    me.playingCardAsAction = true
                    me.specialCard:moveTo(enemyCardX, enemyCardY)
                else
                    basePlayCard(me)
                end
            end,
            chooseActionSlot = function(self)
                baseChooseActionSlot(self)
            end,
            pickCard = function(self)
                table.add(self.hand, decks.BansheeDeck:pickCards(1))
            end,
            dropCard = function(self)
                dropFirstHandCard(self)
            end,
            changeLife = function(self, value)
                changeLife(self, value)
            end
        },
        ghost = {
            name = '怨煞灵',
            portrait = imgGhostPortrait,
            initLife = 6,
            deck = 'GhostDeck',
            handSize = 3,
            spriteWidth = 40,
            spriteHeight = 48,
            isShaking = false,
            isImmuneGrave = true,
            isInited = false,
            x = 0,
            y = -120,
            specialCard = Card(actions.container.graveWorld, nil, specialCardX, specialCardY),
            damageTip = {x = -4, baseY = -4, y = -4, img = imgDamageTip, value = 0},
            healTip = {x = 16, baseY = -4, y = -4, img = imgHealTip, value = 0},
            init = function(self, onComplete)
                baseInit(self, decks.GhostDeck, onComplete)
            end,
            drawInfo = function(self, x, y)
                baseDrawInfo(self, x, y)
            end,
            drawPlayingCard = function(self)
                baseDrawPlayingCard(self)
            end,
            drawSprite = function(self, mapX, mapY)
                baseDrawSprite(self, imgGhostSprite, mapX, mapY)
            end,
            drawSelectSlot = function(self)
                if self.targetSlot == nil or self.targetSlot == 0 then return end

                local slot = map.slots[self.targetSlot]
                setColor(red)
                love.graphics.draw(imgSlotSelect, mapX + slot.x, mapY + slot.y)
            end,
            playCard = function(me, opponent)
                me.isPlayingSpecialCard = false
                me.specialCounter = me.specialCounter+1
                if me.specialCounter >= 3 then
                    me.specialCounter = 0
                    me.isPlayingSpecialCard = true
                    me.playingCard = me.specialCard
                    me.playingCardAsAction = true
                    me.specialCard:moveTo(enemyCardX, enemyCardY)
                else
                    basePlayCard(me)
                end
            end,
            chooseActionSlot = function(self)
                baseChooseActionSlot(self)
            end,
            pickCard = function(self)
                table.add(self.hand, decks.GhostDeck:pickCards(1))
            end,
            dropCard = function(self)
                dropFirstHandCard(self)
            end,
            changeLife = function(self, value)
                changeLife(self, value)
            end
        },
        troll = {
            name = '巨魔',
            portrait = imgTrollPortrait,
            initLife = 7,
            deck = 'TrollDeck',
            handSize = 3,
            spriteWidth = 36,
            spriteHeight = 37,
            isShaking = false,
            isInited = false,
            x = 0,
            y = -120,
            specialCard = Card(actions.container.jump, nil, specialCardX, specialCardY),
            damageTip = {x = -4, baseY = -4, y = -4, img = imgDamageTip, value = 0},
            healTip = {x = 16, baseY = -4, y = -4, img = imgHealTip, value = 0},
            init = function(self, onComplete)
                baseInit(self, decks.GhostDeck, onComplete)
            end,
            drawInfo = function(self, x, y)
                baseDrawInfo(self, x, y)
            end,
            drawPlayingCard = function(self)
                baseDrawPlayingCard(self)
            end,
            drawSprite = function(self, mapX, mapY)
                baseDrawSprite(self, imgTrollSprite, mapX, mapY)
            end,
            drawSelectSlot = function(self)
                if self.targetSlot == nil or self.targetSlot == 0 then return end

                local slot = map.slots[self.targetSlot]
                setColor(red)
                love.graphics.draw(imgSlotSelect, mapX + slot.x, mapY + slot.y)
            end,
            playCard = function(me, opponent)
                me.isPlayingSpecialCard = false
                me.specialCounter = me.specialCounter+1
                if me.specialCounter >= 3 then
                    me.specialCounter = 0
                    me.isPlayingSpecialCard = true
                    me.playingCard = me.specialCard
                    me.playingCardAsAction = true
                    me.targetSlot = opponent.slot
                    me.specialCard:moveTo(enemyCardX, enemyCardY)
                else
                    basePlayCard(me)
                end
            end,
            chooseActionSlot = function(self)
                baseChooseActionSlot(self)
            end,
            pickCard = function(self)
                table.add(self.hand, decks.TrollDeck:pickCards(1))
            end,
            dropCard = function(self)
                dropFirstHandCard(self)
            end,
            changeLife = function(self, value)
                changeLife(self, value)
            end
        }
    }
}
return Enemies