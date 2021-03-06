local function cardFlyToHand(self, id, card, time)
    local xInterval = (playerHandWidth - cardWidth)/(#self.hand <= 1 and 1 or #self.hand-1)
    local targetX = playerHandX + (id-1)*(xInterval > cardWidth+1 and cardWidth+1 or xInterval)
    local targetY = playerHandY - (self.currentCardId == id and 4 or 0)
    card:moveTo(targetX, targetY, time)
end

local Player = {
    name = i18n.namePlayer,
    portrait = imgPlayerPortrait,
    initLife = 8,
    life = 8,
    deck = 'PlayerDeck',
    handSize = 3,
    rewardSize = 3,
    spriteWidth = 8,
    spriteHeight = 18,
    isShaking = false,
    isInited = false,
    x = 0,
    y = -120,
    damageTip = {x = -4, baseY = -6, y = -6, img = imgDamageTip, value = 0},
    healTip = {x = 16, baseY = -6, y = -6, img = imgHealTip, value = 0},
    init = function(self, onComplete)
        self.life = self.initLife
        self.slot = 1
        charMove(self, 1, 'arrive', function()
            self.isInited = true
            self.hand = decks.PlayerDeck:pickCards(self.handSize)
            self.currentCardId = 1
            onComplete()
        end)
    end,
    upgrade = function(self)
        self.initLife = self.initLife + 1
    end,
    drawInfo = function(self, x, y)
        setColor(white)
        love.graphics.draw(imgPlayerFrame, x, y)
        
        --portrait
        love.graphics.draw(self.portrait, x+6, y+4)
        
        --name
        love.graphics.printf(self.name, x, y+32, 50, 'center')
        
        --life--
        love.graphics.draw(imgHPBg, x+41, y)
        love.graphics.setFont(fontNum)
        love.graphics.printf(tostring(self.life), x+41, y+1, 18, 'center')
        love.graphics.setFont(fontCN)
    end,
    drawHand  = function(self)
        if self.hand == nil or #self.hand == 0 then return end
        
        for id, card in pairs(self.hand) do
            if id~=currentCardId then
                card:draw()
            end
        end
        if self.currentCardId~=0 and self.currentCardId<=#self.hand then
            self.hand[self.currentCardId]:draw()
        end
    end,
    drawSprite = function(self, mapX, mapY)
        local shakeX = 0
        if self.isShaking then
            shakeX = love.math.random(-2, 2)
        end
        setColor(white)
        love.graphics.draw(imgPlayerSprite, mapX + self.x + shakeX, mapY + self.y)
        --spritePlayer:draw(mapX + self.x + shakeX, mapY + self.y)
        
        -- draw tips
        drawTip(self, self.damageTip)
        drawTip(self, self.healTip)
    end,
    update = function(self, dt)
    end,
    selectNext = function(self)
        if self.hand == nil or #self.hand == 0 then return end
        
        local prevId = self.currentCardId
        local id = self.currentCardId + 1
        if id > #self.hand then
            id = 1
        end
        self.currentCardId = id
        
        cardFlyToHand(self, prevId, self.hand[prevId],0.1)
        cardFlyToHand(self, self.currentCardId, self.hand[self.currentCardId],0.1)
    end,
    selectPrev = function(self)
        if self.hand == nil or #self.hand == 0 then return end

        local prevId = self.currentCardId
        local id = self.currentCardId - 1
        if id < 1 then
            id = #self.hand
        end
        self.currentCardId = id
        
        cardFlyToHand(self, prevId, self.hand[prevId],0.1)
        cardFlyToHand(self, self.currentCardId, self.hand[self.currentCardId],0.1)
    end,
    playCard = function(me, opponent)
        me.playingCard = me.hand[me.currentCardId]
        me.playingCardAsAction = me.playingCard.isShowAction
        if not me.playingCardAsAction then
            -- play space card always need choose slot
            return true
        elseif me.playingCardAsAction and me.playingCard.action.needChooseSlot then
            return true
        end
        return false
    end,
    pickCard = function(self)
        local card = decks.PlayerDeck:pickCards(1)
        -- unify card direction
        if #self.hand > 0 then card.isShowAction = self.hand[1].isShowAction end
        table.add(self.hand, card)
        print('player pick: '..card.action.name..'|'..card.space.name)
    end,
    dropCard = function(self)
        dropFirstHandCard(self)
    end,
    changeLife = function(self, value)
        changeLife(self, value)
    end,
    updateHandCardPositions = function(self)
        for i, card in pairs(self.hand) do
            cardFlyToHand(self, i, card)
        end
    end,
    hideUnplayedHandCards = function(self, onComplete)
        if #self.hand <= 1 then
            onComplete()
            return
        end

        for i, card in pairs(self.hand) do
            if card ~= self.playingCard then
                card:moveTo(card.x, playerHandHideY, 0.1, onComplete)
            end
        end
    end
}
return Player