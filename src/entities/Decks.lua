return {
    PublicDeck = {
        size = 40,
        scoreRange = {4,10},
        draw = function(self, x, y)
            local width = 40
            local height = 64
    
            setColor({136, 151, 166})
            love.graphics.rectangle('fill', x, y, width, height)
            
            --card count
            drawText(tostring(#self.cards), x+10, y+48)
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