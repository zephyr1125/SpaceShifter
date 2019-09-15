RewardState = {}

local function drawCard(id, card)
    card:draw()
    -- draw selection
    if card.isRewardSelected then
        setColor(white)
        love.graphics.draw(imgRewardSelect, card.x + cardWidth - 16, card.y + 2)
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
    infoBar:setCardInfo(map.slots[self.currentCardId].baseCard)
end

function RewardState:init()
    self.confirmButton = Button(i18n.confirm, buttonWidth, buttonHeight,
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
    refreshInfoBar(self)
end

function RewardState:draw()
    setColor(coverColor)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
    
    setColor(white)
    love.graphics.printf(i18n.chooseReward, 0, 64, screenWidth, 'center')
    
    setColor(white)
    self:drawRewards(32, 96, screenWidth-64)

    self.confirmButton:draw((screenWidth-buttonWidth)/2, 96 + 64 + 16)
    
    infoBar:draw(infoBarX, infoBarY)
end

function RewardState:drawRewards(x, y, width)
    local xInterval = (width - cardWidth)/6
    for id, slot in pairs(map.slots) do
        if id ~= self.currentCardId then
            drawCard(id, slot.baseCard)
        end
    end
    if self.currentCardId ~= 0 then
        drawCard(self.currentCardId, map.slots[self.currentCardId].baseCard)
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
    local prevId = self.currentCardId
    local id = self.currentCardId + 1
    if id > #map.slots then
        id = 1
    end
    self.currentCardId = id
    
    map.slots[prevId].baseCard:moveTo(rewardCardX+(prevId-1)*rewardCardInterval, rewardCardY, 0.1)
    map.slots[self.currentCardId].baseCard:moveTo(
            rewardCardX+(id-1)*rewardCardInterval, rewardCardY-4, 0.1)
end

function RewardState:selectLeft()
    local prevId = self.currentCardId
    local id = self.currentCardId - 1
    if id <1 then
        id = #map.slots
    end
    self.currentCardId = id

    map.slots[prevId].baseCard:moveTo(rewardCardX+(prevId-1)*rewardCardInterval, rewardCardY, 0.1)
    map.slots[self.currentCardId].baseCard:moveTo(
            rewardCardX+(id-1)*rewardCardInterval, rewardCardY-4, 0.1)
end

function RewardState:keypressed(key)
    if key == keys.Y then
        for id, slot in pairs(map.slots) do
            if id == self.currentCardId then
                slot.baseCard:flip(self, refreshInfoBar)
            else
                slot.baseCard:flip()
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