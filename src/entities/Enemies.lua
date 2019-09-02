local baseDrawInfo = function(self, x, y)
    setColor(enemyInfoBgColor)
    love.graphics.rectangle('fill', x,y, cardWidth, cardHeight)

    --life--
    setColor(white)
    love.graphics.printf(tostring(self.life), x, y+cardHeight-fontSize-4, cardWidth, 'center')
end

local basePlayCard = function(self)
    if self.hands == nil or #self.hands == 0 then return end
    -- just random hand card
    local cardId = random(#self.hands)
    self.playingCard = table.remove(self.hands, cardId)
    self.playingCardAsAction = true
    if self.playingCard.action.needChooseSlot then
        return true
    end
    return false
end

local baseDrawPlayingCard = function(self, x, y)
    if(self.playingCard ~= nil) then
        drawCardAsAction(self.playingCard, x, y)
    end
end

local baseDrawSprite = function(self, imageSprite, mapX, mapY)
    setColor(white)
    love.graphics.draw(imageSprite,
            mapX + map.slots[self.slot].x
                    + math.floor(mapSlotWidth/2) - imageSprite:getWidth()/2,
            mapY + map.slots[self.slot].y
                    + math.floor(mapSlotHeight/2) - imageSprite:getHeight())
end

local baseChooseActionSlot = function(self)
    -- todo choose slot base on action type, may write on action
    local neighbours = map:getNeighbours(self.slot)
    self.targetSlot = neighbours[random(#neighbours)]
end

return {
    {
        name = 'Banshee',
        life = 5,
        deck = 'BansheeDeck',
        handSize = 3,
        init = function(self)
            self.slot = 7
            self.hands = decks.BansheeDeck:pickCards(self.handSize)
        end,
        drawInfo = function(self, x, y)
            baseDrawInfo(self, x, y)
        end,
        drawPlayingCard = function(self, x, y)
            baseDrawPlayingCard(self, x, y)
        end,
        drawSprite = function(self, mapX, mapY)
            baseDrawSprite(self, imgBansheeSprite, mapX, mapY)
        end,
        playCard = function(self)
            return basePlayCard(self)
        end,
        chooseActionSlot = function(self)
            baseChooseActionSlot(self)
        end
    }
}