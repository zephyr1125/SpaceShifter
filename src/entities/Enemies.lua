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
end

local baseDrawPlayingCard = function(self, x, y)
    if(self.playingCard ~= nil) then
        drawCardAsAction(self.playingCard, x, y)
    end
end

return {
    {
        name = 'Banshee',
        life = 5,
        deck = 'BansheeDeck',
        img = 'banshee',
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
        playCard = function(self)
            basePlayCard(self)
        end
    }
}