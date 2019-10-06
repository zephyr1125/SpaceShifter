DiscardCardState = {}

local function drawCard(id, card)
    card:draw()
    -- draw selection
    if card.isDiscardSelected then
        setColor(white)
        love.graphics.draw(imgDiscardSelect, card.x + cardWidth - 16, card.y + 2)
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

local function refreshInfoBar(self)
    infoBar:setCardInfo(decks.PlayerDeck.cards[self.currentCardId])
end

local function RefreshSelectCard(prevId, newId)
    local prevCard = decks.PlayerDeck.cards[prevId]
    local newCard = decks.PlayerDeck.cards[newId]
    prevCard:moveTo(prevCard.x, prevCard.y+3, 0.1)
    newCard:moveTo(newCard.x, newCard.y-3, 0.1)
end

function DiscardCardState:init()
    self.confirmButton = Button(i18n.confirm, buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                if not isDiscardFull() then return end
                self:confirmSelection()
                for i, card in pairs(decks.PlayerDeck.cards) do
                    card:moveTo(decks.PlayerDeck.x, decks.PlayerDeck.y, 0.3,
                        i == #decks.PlayerDeck.cards and function()
                            GameState.switch(NextEnemyState)
                        end or nil)
                end
            end)
end

function DiscardCardState:enter()
    self.currentCardId = 1
    self.isSelectingCard = true
    self.confirmButton:setSelect(false)

    local xInterval = 4
    local yInterval = 4
    local width = 5*cardWidth + 4*xInterval
    local startX = screenWidth/2- width/2
    local startY = 22
    
    for id, card in pairs(decks.PlayerDeck.cards) do
        card.isDiscardSelected = false
        card.isShowAction = true
        local selectionOffsetY
        if id == 1 then selectionOffsetY = -3 else selectionOffsetY = 0 end
        local x = startX + math.fmod(id-1, 5) * (cardWidth + xInterval)
        local y = startY + math.floor((id-1)/5) * (cardHeight + yInterval) + selectionOffsetY
        card:moveTo(x, y)
    end
    
    cursor:setVisible(true)
    
    infoBar:setShowFlipInfo(true)
    refreshInfoBar(self)
end

function DiscardCardState:draw()
    setColor(coverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)

    setColor(white)
    love.graphics.printf(i18n.dropUntil12, 0, 4, screenWidth, 'center')

    setColor(white)
    self:drawPlayerDeck()

    self.confirmButton:draw((screenWidth-buttonWidth)/2, screenHeight - 28 - buttonHeight)

    infoBar:draw(infoBarX, infoBarY)
    
    cursor:draw()
end

function DiscardCardState:drawPlayerDeck()
    for id, card in pairs(decks.PlayerDeck.cards) do
        if id ~= self.currentCardId or not self.isSelectingCard then
            drawCard(id, card)
        end
    end
    if self.currentCardId ~= 0 and self.isSelectingCard then
        drawCard(self.currentCardId, decks.PlayerDeck.cards[self.currentCardId])
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
    local prevId = self.currentCardId
    local id = self.currentCardId - 1
    if id < 1 then
        id = #decks.PlayerDeck.cards
    end
    self.currentCardId = id
    RefreshSelectCard(prevId, id)
end

function DiscardCardState:selectRight()
    self:setSelectingCard(true)
    local prevId = self.currentCardId
    local id = self.currentCardId + 1
    if id > #decks.PlayerDeck.cards then
        id = 1
    end
    self.currentCardId = id
    RefreshSelectCard(prevId, id)
end

function DiscardCardState:selectUp()
    if not self.isSelectingCard then
        self:setSelectingCard(true)
    else
        local prevId = self.currentCardId
        local id = self.currentCardId - 5
        if id >= 1 then
            self.currentCardId = id
            RefreshSelectCard(prevId, id)
        end
    end
end

function DiscardCardState:selectDown()
    local id = self.currentCardId + 5
    if id <= #decks.PlayerDeck.cards then
        self:setSelectingCard(true)
        local prevId = self.currentCardId
        self.currentCardId = id
        RefreshSelectCard(prevId, id)
    else
        self:setSelectingCard(false)
    end
end

function DiscardCardState:update(dt)
    if self.isSelectingCard then
        cursor:moveToCard(decks.PlayerDeck.cards[self.currentCardId])
    end
end

function DiscardCardState:keypressed(key)
    if key == keys.Y then
        for id, card in pairs(decks.PlayerDeck.cards) do
            if id == self.currentCardId then
                card:flip(self, refreshInfoBar)
            else
                card:flip()
            end
        end
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

    refreshInfoBar(self)

    self.confirmButton:keypressed(key)
end

function DiscardCardState:setSelectingCard(isSelectingCard)
    self.isSelectingCard = isSelectingCard
    self.confirmButton:setSelect(not isSelectingCard)
end