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
end

local baseDrawPlayingCard = function(self, x, y)
    if(self.playingCard ~= nil) then
        drawCardAsAction(self.playingCard, x, y)
    end
end

local baseDrawSprite = function(self, imageSprite, mapX, mapY)
    setColor(white)
    love.graphics.draw(imageSprite,
            mapX + map.slots[self.slot].x
                    + math.floor(mapSlotWidth/2) - imageSprite:getWidth()/2,
            mapY + map.slots[self.slot].y
                    + math.floor(mapSlotHeight/2) - imageSprite:getHeight())
end

local baseChooseActionSlot = function(self, action)
    self.targetSlot = action.aiTargetSlot(self, player)
end

return {
    {
        name = 'Banshee',
        initLife = 5,
        deck = 'BansheeDeck',
        handSize = 3,
        init = function(self)
            self.life = self.initLife
            self.slot = 7
            self.hand = decks.BansheeDeck:pickCards(self.handSize)
        end,
        drawInfo = function(self, x, y)
            baseDrawInfo(self, x, y)
        end,
        drawPlayingCard = function(self, x, y)
            baseDrawPlayingCard(self, x, y)
        end,
        drawSprite = function(self, mapX, mapY)
            baseDrawSprite(self, imgBansheeSprite, mapX, mapY)
        end,
        playCard = function(self)
            basePlayCard(self)
        end,
        chooseActionSlot = function(self)
            baseChooseActionSlot(self)
        end,
        pickCard = function(self)
            self.hand[#self.hand+1] = decks.BansheeDeck:pickCards(1)
        end,
        dropCard = function(self)
            dropFirstHandCard(self)
        end
    },
    {
        name = 'Greed',
        initLife = 7,
        deck = 'GreedDeck',
        handSize = 3,
        init = function(self)
            self.life = self.initLife
            self.slot = 7
            self.hand = decks.GreedDeck:pickCards(self.handSize)
        end,
        drawInfo = function(self, x, y)
            baseDrawInfo(self, x, y)
        end,
        drawPlayingCard = function(self, x, y)
            baseDrawPlayingCard(self, x, y)
        end,
        drawSprite = function(self, mapX, mapY)
            baseDrawSprite(self, imgGreedSprite, mapX, mapY)
        end,
        playCard = function(self)
            basePlayCard(self)
        end,
        chooseActionSlot = function(self)
            baseChooseActionSlot(self)
        end,
        pickCard = function(self)
            self.hand[#self.hand+1] = decks.GreedDeck:pickCards(1)
        end,
        dropCard = function(self)
            dropFirstHandCard(self)
        end
    }
}