local function drawHandCard(id, card, handX, xInterval, handY, width)
    local cardX = handX + width - cardWidth -
            (id-1)*(xInterval > cardWidth+4 and cardWidth+4 or xInterval)
    drawCardAsAction(card, cardX, handY)
end

return {
    life = 5,
    deck = 'PlayerDeck',
    handSize = 3,
    hand = {},
    init = function(self)
        decks.PlayerDeck:pickCards(self.hand, self.handSize)
        self.currentCardId = #self.hand
    end,
    drawHand  = function(self, x, y, width)
        if #self.hand == 0 then return end

        local xInterval = (width - cardWidth)/(#self.hand <= 1 and 1 or #self.hand-1)
        for id, card in pairs(self.hand) do
            if id ~= self.currentCardId then
                drawHandCard(id, card, x, xInterval, y, width)
            end
        end
        drawHandCard(self.currentCardId, self.hand[self.currentCardId],
                x, xInterval, y-4, width)
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