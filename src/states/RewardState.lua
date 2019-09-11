RewardState = {}

local function drawCard(id, card, x, xInterval, y, cardAsAction)
    local cardX = x + (id-1)*xInterval
    card:draw(cardX, y)
    -- draw selection
    if card.isRewardSelected then
        setColor(white)
        love.graphics.draw(imgRewardSelect, cardX + cardWidth - 16, y + 2)
    end
end

local function isRewardFull()
    local rewardCount = 0
    for _, slot in pairs(map.slots) do
        if slot.baseCard.isRewardSelected then
            rewardCount = rewardCount + 1
        end
    end
    return rewardCount >= player.rewardSize
end

local function refreshInfoBar(self)
    infoBar:setCardInfo(map.slots[self.currentCardId].card)
end

function RewardState:init()
    self.confirmButton = Button('Confirm', buttonWidth, buttonHeight,
            buttonIdleColor, buttonSelectColor, function()
                self:confirmSelection()
                if #decks.PlayerDeck.cards > decks.PlayerDeck.size then
                    GameState.switch(DiscardCardState)
                else
                    GameState.switch(NextEnemyState)
                end
            end)
end

function RewardState:enter()
    self.currentCardId = 1
    self.isSelectingCard = true
    self.confirmButton:setSelect(false)

    for _, slot in pairs(map.slots) do
        slot.baseCard.isRewardSelected = false
    end

    infoBar:setShowFlipInfo(true)
    infoBar:setCardInfo(map.slots[self.currentCardId].card)
end

function RewardState:draw()
    setColor(coverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
    
    setColor(white)
    love.graphics.printf('选择你的奖励', 0, 64, screenWidth, 'center')
    
    setColor(white)
    self:drawRewards(32, 96, screenWidth-64)

    self.confirmButton:draw((screenWidth-buttonWidth)/2, 96 + 64 + 16)
    
    infoBar:draw(infoBarX, infoBarY)
end

function RewardState:drawRewards(x, y, width)
    local xInterval = (width - cardWidth)/6
    for id, slot in pairs(map.slots) do
        if id ~= self.currentCardId then
            drawCard(id, slot.baseCard, x, xInterval, y)
        end
    end
    if self.currentCardId ~= 0 then
        drawCard(self.currentCardId, map.slots[self.currentCardId].baseCard,
                x, xInterval, y+4)
    end
end

function RewardState:confirmSelection()
    for _, slot in pairs(map.slots) do
        if slot.baseCard.isRewardSelected then
            -- selected card into player deck
            table.add(decks.PlayerDeck.cards, slot.baseCard)
        else 
            -- others into public discard pile
            table.add(decks.PublicDeck.discardCards, slot.baseCard)
        end
        slot.baseCard.isRewardSelected = nil
        slot.baseCard = nil
    end
end

function RewardState:selectRight()
    local id = self.currentCardId + 1
    if id > #map.slots then
        id = 1
    end
    self.currentCardId = id
end

function RewardState:selectLeft()
    local id = self.currentCardId - 1
    if id <1 then
        id = #map.slots
    end
    self.currentCardId = id
end

function RewardState:keypressed(key)
    if key == keys.Y then
        for id, slot in pairs(map.slots) do
            if id == self.currentCardId then
                slot.card:flip(self, refreshInfoBar)
            else
                slot.card:flip()
            end
        end
    end

    if key == keys.DPad_left then
        self.isSelectingCard = true
        self.confirmButton:setSelect(false)
        self:selectLeft()
    end

    if key == keys.DPad_right then
        self.isSelectingCard = true
        self.confirmButton:setSelect(false)
        self:selectRight()
    end

    if key == keys.DPad_down then
        self.isSelectingCard = false
        self.confirmButton:setSelect(true)
    end

    if key == keys.DPad_up then
        self.isSelectingCard = true
        self.confirmButton:setSelect(false)
    end

    if key == keys.A and self.isSelectingCard then
        local currentCard = map.slots[self.currentCardId].baseCard
        local selected = currentCard.isRewardSelected
        if isRewardFull() then
            currentCard.isRewardSelected = false
        else
            currentCard.isRewardSelected = not selected
        end
    end

    refreshInfoBar(self)
    
    self.confirmButton:keypressed(key)
end