return {
    PublicDeck = {
        size = 40,
        scoreRange = {4,10},
        draw = function(self, x, y)
            local width = 40
            local height = 64
    
            setColor({136, 151, 166})
            love.graphics.rectangle('fill', x, y, width, height)
            
            --top deck
            
            --card count
            setColor(white)
            love.graphics.printf(tostring(#self.cards), x, y+48, width, 'center')
        end
    },
    PlayerDeck = {
        size = 9,
        scoreRange = {2,2}
    },
    BansheeDeck = {
        size = 9,
        scoreRange = {2,3}
    }
}