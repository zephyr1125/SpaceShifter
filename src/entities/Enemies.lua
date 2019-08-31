local baseDrawInfo = function(enemy, x, y)
    setColor(enemyInfoBgColor)
    love.graphics.rectangle('fill', x,y, cardWidth, cardHeight)

    --life--
    setColor(white)
    love.graphics.printf(tostring(enemy.life), x, y+cardHeight-fontSize-4, cardWidth, 'center')
end

return {
    {
        name = 'Banshee',
        life = 5,
        deck = 'BansheeDeck',
        handSize = 3,
        hand = {},
        init = function(self)
            decks.BansheeDeck:pickCards(self.hand, self.handSize)
        end,
        drawInfo = function(self, x, y)
            baseDrawInfo(self, x, y)
        end,
    }
}