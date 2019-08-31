local function drawHandCard(id, card, handX, xInterval, handY, width, cardAsAction)
    local cardX = handX + width - cardWidth -
            (id-1)*(xInterval > cardWidth+4 and cardWidth+4 or xInterval)
    if cardAsAction then
        drawCardAsAction(card, cardX, handY)
    else
        drawCardAsSpace(card, cardX, handY)
    end
end

return {
    life = 5,
    deck = 'PlayerDeck',
    handSize = 3,
    cardAsAction = true,
    hand = {},
    init = function(self)
        decks.PlayerDeck:pickCards(self.hand, self.handSize)
        self.currentCardId = #self.hand
    end,
    drawInfo = function(self, x, y)
        setColor(playerInfoBgColor)
        love.graphics.rectangle('fill', x,y, cardWidth, cardHeight)
        
        --life--
        setColor(white)
        love.graphics.printf(tostring(self.life), x, y+cardHeight-fontSize-4, cardWidth, 'center')
    end,
    drawHand  = function(self, x, y, width)
        if #self.hand == 0 then return end

        local xInterval = (width - cardWidth)/(#self.hand <= 1 and 1 or #self.hand-1)
        for id, card in pairs(self.hand) do
            if id ~= self.currentCardId then
                drawHandCard(id, card, x, xInterval, y, width, self.cardAsAction)
            end
        end
        drawHandCard(self.currentCardId, self.hand[self.currentCardId],
                x, xInterval, y-4, width, self.cardAsAction)
    end,
    selectNext = function(self)
        local id = self.currentCardId + 1
        if id > #self.hand then
            id = 1
        end
        self.currentCardId = id
    end,
    selectPrev = function(self)
        local id = self.currentCardId - 1
        if id < 1 then
            id = #self.hand
        end
        self.currentCardId = id
    end,
}