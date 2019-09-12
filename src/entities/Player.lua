local function drawHandCard(id, card, handX, xInterval, handY, width)
    local cardX = handX + width - cardWidth -
            (id-1)*(xInterval > cardWidth+1 and cardWidth+1 or xInterval)
    card:draw(cardX, handY)
end

local Player = {
    initLife = 5,
    life = 5,
    deck = 'PlayerDeck',
    handSize = 3,
    rewardSize = 3,
    spriteWidth = 16,
    spriteHeight = 18,
    init = function(self)
        self.life = self.initLife
        self.slot = 1
        charMove(self, 1, 'instant')
        self.hand = decks.PlayerDeck:pickCards(self.handSize)
        self.currentCardId = #self.hand
    end,
    upgrade = function(self)
        self.initLife = self.initLife + 1
    end,
    drawInfo = function(self, x, y)
        setColor(playerInfoBgColor)
        love.graphics.rectangle('fill', x,y, cardWidth, cardHeight)
        
        --life--
        setColor(white)
        love.graphics.printf(tostring(self.life), x, y+cardHeight-fontSize-4, cardWidth, 'center')
    end,
    drawHand  = function(self, x, y, width)
        if self.hand == nil or #self.hand == 0 then return end

        local xInterval = (width - cardWidth)/(#self.hand <= 1 and 1 or #self.hand-1)
        for id, card in pairs(self.hand) do
            if id ~= self.currentCardId then
                drawHandCard(id, card, x, xInterval, y, width)
            end
        end
        if self.currentCardId ~= 0 then
            drawHandCard(self.currentCardId, self.hand[self.currentCardId],
                    x, xInterval, y-4, width)
        end
    end,
    drawSprite = function(self, mapX, mapY)
        setColor(white)
        spritePlayer:draw(mapX + self.x, mapY + self.y)
    end,
    update = function(self, dt)
        spritePlayer:update(dt)
    end,
    selectNext = function(self)
        if self.hand == nil or #self.hand == 0 then return end
        
        local id = self.currentCardId + 1
        if id > #self.hand then
            id = 1
        end
        self.currentCardId = id
    end,
    selectPrev = function(self)
        if self.hand == nil or #self.hand == 0 then return end
        
        local id = self.currentCardId - 1
        if id < 1 then
            id = #self.hand
        end
        self.currentCardId = id
    end,
    -- returns if the card need choose slot
    playCard = function(self)
        self.playingCard = self.hand[self.currentCardId]
        self.playingCardAsAction = self.playingCard.isShowAction
        if not self.playingCardAsAction then
            -- play space card always need choose slot
            return true
        elseif self.playingCardAsAction and self.playingCard.action.needChooseSlot then
            return true
        end
        return false
    end,
    pickCard = function(self)
        local card = decks.PlayerDeck:pickCards(1)
        -- unify card direction
        if #self.hand > 0 then card.isShowAction = self.hand[1].isShowAction end
        table.add(self.hand, card)
    end,
    dropCard = function(self)
        dropFirstHandCard(self)
    end
}
return Player