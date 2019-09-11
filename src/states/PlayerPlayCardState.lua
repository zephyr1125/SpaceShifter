local noTips, mapTips, enemyTips = 1,2,3

local function enterNoTips(self)
    self.tipsStatus = noTips
    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end

local function enterMapTips(self)
    self.tipsStatus = mapTips
    self.mapTipId = 5
    infoBar:setCardInfo(map.slots[self.mapTipId].card, false)
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
        enterMapTips(self)
        return
    end

    if key == keys.Y then
        player.cardAsAction = not player.cardAsAction
    end

    if key == keys.A then
        local needChooseSlot = player:playCard()
        if needChooseSlot then
            GameState.switch(PlayerChooseSlotState)
        else
            GameState.switch(ResolutionState)
        end
    end

    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end

local function mapTipsKeyPressed(self, key)
    if key == keys.B or key == keys.A then
        enterNoTips(self)
        return
    end

    infoBar:setCardInfo(map.slots[self.mapTipId].card, false)
end

PlayerPlayCardState = {}
function PlayerPlayCardState:enter()
    print("player state")
    player.currentCardId = #player.hand
    enterNoTips(self)
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