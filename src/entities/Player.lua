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
    drawHand  = function(self, x, y, width, selection)
        if #self.hand == 0 then return end
        
        selection = selection or self.hand[#self.hand]
        local xInterval = (width - cardWidth)/(#self.hand <= 1 and 1 or #self.hand-1)
        local selectionId
        for id, card in pairs(self.hand) do
            if card ~= selection then
                drawHandCard(id, card, x, xInterval, y, width)
            else
                selectionId = id
            end
        end
        drawHandCard(selectionId, selection, x, xInterval, y-4, width)
    end
}