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
                if not isDiscardFull() then return end
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
        if id ~= self.currentCardId or not self.isSelectingCard then
            drawCard(id, card,
                x + math.fmod(id-1, 5) * (cardWidth + xInterval),
                y + math.floor((id-1)/5) * (cardHeight + yInterval),
                self.showAction)
        end
    end
    if self.currentCardId ~= 0 and self.isSelectingCard then
        drawCard(self.currentCardId, decks.PlayerDeck.cards[self.currentCardId],
            x + math.fmod(self.currentCardId-1, 5) * (cardWidth + xInterval),
            y + math.floor((self.currentCardId-1)/5) * (cardHeight + yInterval) - 3,
            self.showAction)
    end
end

function DiscardCardState:confirmSelection()
    for i = #decks.PlayerDeck.cards, 1, -1 do
        local card = decks.PlayerDeck.cards[i]
        if card.isDiscardSelected then
            -- selected card removed
            table.remove(decks.PlayerDeck.cards, i)
        end
        card.isDiscardSelected = nil
    end
end

function DiscardCardState:selectLeft()
    self:setSelectingCard(true)
    local id = self.currentCardId - 1
    if id < 1 then
        id = #decks.PlayerDeck.cards
    end
    self.currentCardId = id
end

function DiscardCardState:selectRight()
    self:setSelectingCard(true)
    local id = self.currentCardId + 1
    if id > #decks.PlayerDeck.cards then
        id = 1
    end
    self.currentCardId = id
end

function DiscardCardState:selectUp()
    if not self.isSelectingCard then
        self:setSelectingCard(true)
    else
        local id = self.currentCardId - 5
        if id >= 1 then
            self.currentCardId = id
        end
    end
end

function DiscardCardState:selectDown()
    local id = self.currentCardId + 5
    if id <= #decks.PlayerDeck.cards then
        self:setSelectingCard(true)
        self.currentCardId = id
    else
        self:setSelectingCard(false)
    end
end

function DiscardCardState:keypressed(key)
    if key == keys.Y then
        self.showAction = not self.showAction
    end

    if key == keys.DPad_left then
        self:selectLeft()
    end

    if key == keys.DPad_right then
        self:selectRight()
    end

    if key == keys.DPad_up then
        self:selectUp()
    end

    if key == keys.DPad_down then
        self:selectDown()
    end

    if key == keys.A and self.isSelectingCard then
        local currentCard = decks.PlayerDeck.cards[self.currentCardId]
        local selected = currentCard.isDiscardSelected
        if isDiscardFull() then
            currentCard.isDiscardSelected = false
        else
            currentCard.isDiscardSelected = not selected
        end
    end

    self.confirmButton:keypressed(key)
end

function DiscardCardState:setSelectingCard(isSelectingCard)
    self.isSelectingCard = isSelectingCard
    self.confirmButton:setSelect(not isSelectingCard)
end