DiscardCardState = {}

local function drawCard(id, card, x, y, cardAsAction)
    if cardAsAction then
        drawCardAsAction(card, x, y)
    else
        drawCardAsSpace(card, x, y)
    end
    -- draw selection
    if card.isDiscardSelected then
        setColor(white)
        love.graphics.draw(imgDiscardSelect, x + cardWidth - 16, y + 2)
    end
end

local function isDiscardFull()
    local discardSum = #decks.PlayerDeck.cards - decks.PlayerDeck.size
    for _, card in pairs(decks.PlayerDeck.cards) do
        if card.isDiscardSelected then
            discardSum = discardSum - 1
        end
    end
    return discardSum <= 0
end

function DiscardCardState:init()
    self.confirmButton = Button('Confirm', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                self:confirmSelection()
                GameState.switch(NextEnemyState)
            end)
end

function DiscardCardState:enter()
    self.showAction = true
    self.currentCardId = 1
    self.isSelectingCard = true

    for _, card in pairs(decks.PlayerDeck.cards) do
        card.isDiscardSelected = false
    end
end

function DiscardCardState:draw()
    setColor(coverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)

    setColor(white)
    love.graphics.printf('弃牌直至你的牌库为12张', 0, 4, screenWidth, 'center')

    setColor(white)
    self:drawPlayerDeck(screenWidth/2, 24, 4, 4)

    self.confirmButton:draw((screenWidth-buttonWidth)/2, screenHeight - 8 - buttonHeight)
end

function DiscardCardState:drawPlayerDeck(x, y, xInterval, yInterval)
    -- 5 * 3 layer
    local width = 5*cardWidth + 4*xInterval
    x = x - width/2
    for id, card in pairs(decks.PlayerDeck.cards) do
        if id ~= self.currentCardId then
            drawCard(id, card,
                x + math.fmod(id-1, 5) * (cardWidth + xInterval),
                y + math.floor((id-1)/5) * (cardHeight + yInterval),
                self.showAction)
        end
    end
    if self.currentCardId ~= 0 then
        drawCard(self.currentCardId, decks.PlayerDeck.cards[self.currentCardId],
            x + math.fmod(self.currentCardId-1, 5) * (cardWidth + xInterval),
            y + math.floor((self.currentCardId-1)/5) * (cardHeight + yInterval),
            self.showAction)
    end
end

function DiscardCardState:confirmSelection()
    --for _, slot in pairs(map.slots) do
    --    if slot.baseCard.isRewardSelected then
    --        -- selected card into player deck
    --        decks.PlayerDeck.cards[#decks.PlayerDeck.cards+1] = slot.baseCard
    --    else
    --        -- others into public discard pile
    --        decks.PublicDeck.discardCards[#decks.PublicDeck.discardCards +1 ] =
    --        slot.baseCard
    --    end
    --    slot.baseCard.isRewardSelected = nil
    --    slot.baseCard = nil
    --end
end