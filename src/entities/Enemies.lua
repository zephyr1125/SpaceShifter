local function baseInit(self, deck, onComplete)
    self.life = self.initLife
    self.slot = 7
    charMove(self, self.slot, 'arrive', function()
        self.hand = deck:pickCards(self.handSize)
        self.specialCounter = 0
        onComplete()
    end)
end

local baseDrawInfo = function(self, x, y)
    setColor(enemyInfoBgColor)
    love.graphics.rectangle('fill', x,y, cardWidth, cardHeight)

    --life--
    setColor(white)
    love.graphics.printf(tostring(self.life), x, y+cardHeight-fontSize-4, cardWidth, 'center')
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
    
    -- space too bad, move to best neighbour
    if cardId == 0 then
        local bestBenefitSlot = map:getBestBenefitNeighbour(me.slot)
        if bestBenefitSlot ~= me.slot then
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
    setColor(black)
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
            initLife = 0,
            deck = 'BansheeDeck',
            handSize = 3,
            spriteWidth = 42,
            spriteHeight = 44,
            isShaking = false,
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
            name = '鬼魂',
            initLife = 7,
            deck = 'GhostDeck',
            handSize = 3,
            spriteWidth = 44,
            spriteHeight = 44,
            isShaking = false,
            isImmuneGrave = true,
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
                if targetSlot == 0 then return end

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
            initLife = 7,
            deck = 'TrollDeck',
            handSize = 3,
            spriteWidth = 44,
            spriteHeight = 44,
            isShaking = false,
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
                if targetSlot == 0 then return end

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