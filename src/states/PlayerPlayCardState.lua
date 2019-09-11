local noTips, mapTips, enemyTips = 1,2,3

local function enterNoTips(self)
    self.tipsStatus = noTips
    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end

local function enterMapTips(self, isFromBottom)
    self.tipsStatus = mapTips
    self.mapTipSlot = isFromBottom and 5 or 2
    infoBar:setCardInfo(map.slots[self.mapTipSlot].card, false)
end

local function enterEnemyTips(self)
    self.tipsStatus = enemyTips
    infoBar:setCardInfo(currentEnemy.playingCard, true)
end

local function noTipsKeyPressed(self, key)
    if key == keys.B then
        -- todo open system window
        screenManager:view('/')
    end

    if key == keys.DPad_right then
        player:selectPrev()
    end

    if key == keys.DPad_left then
        player:selectNext()
    end

    if key == keys.DPad_up then
        enterMapTips(self, true)
        return
    end

    if key == keys.Y then
        player.cardAsAction = not player.cardAsAction
    end
    
    if key == keys.A then
        local needChooseSlot = player:playCard()
        if needChooseSlot then
            GameState.switch(PlayerChooseSlotState)
            return
        else
            GameState.switch(ResolutionState)
            return
        end
    end

    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end

local function mapTipsKeyPressed(self, key)
    if key == keys.B or key == keys.A then
        enterNoTips(self)
        return
    end
    
    local next
    local neighbours = map:getNeighbours(self.mapTipSlot)
    if key == keys.DPad_up then
        next = neighbours[1]
        if next == 0 then
            enterEnemyTips(self)
            return
        else
            self.mapTipSlot = next
        end
    elseif key == keys.DPad_down then
        next = neighbours[4]
        if next == 0 then
            enterNoTips(self)
            return
        else
            self.mapTipSlot = next
        end
    elseif key == keys.DPad_left then
        next = neighbours[6]
        if next == 0 then
            next = neighbours[5]
        end
        if next ~= 0 then
            self.mapTipSlot = next
        end
    elseif key == keys.DPad_right then
        next = neighbours[2]
        if next == 0 then
            next = neighbours[3]
        end
        if next ~= 0 then
            self.mapTipSlot = next
        end
    end

    infoBar:setCardInfo(map.slots[self.mapTipSlot].card, false)
end

local function enemyTipsKeyPressed(self, key)
    if key == keys.B or key == keys.A then
        enterNoTips(self)
        return
    end

    if key == keys.DPad_down then
        enterMapTips(self, false)
        return
    end

    infoBar:setCardInfo(currentEnemy.playingCard, true)
end

PlayerPlayCardState = {}
function PlayerPlayCardState:enter()
    print("player state")
    player.currentCardId = #player.hand
    enterNoTips(self)
end

function PlayerPlayCardState:draw()
    setColor(white)
    if self.tipsStatus == mapTips then
        local slot = map.slots[self.mapTipSlot]
        love.graphics.draw(imgTipCursor, mapX + slot.x + 48,
                mapY + slot.y + 26)
    elseif self.tipsStatus == enemyTips then
        love.graphics.draw(imgTipCursor, enemyCardX + cardWidth/2,
                enemyCardY + cardHeight - 8)
    end
end

function PlayerPlayCardState:keypressed(key)
    if self.tipsStatus == noTips then
        noTipsKeyPressed(self, key)
    elseif self.tipsStatus == mapTips then
        mapTipsKeyPressed(self, key)
    else
        enemyTipsKeyPressed(self, key)
    end
end