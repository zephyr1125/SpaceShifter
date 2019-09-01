return {
    slots = {
        {
            up = 2,
            down = 6,
            left = nil,
            right = 7,
            x = 0,
            y = 16
        },
        {
            up = nil,
            down = 7,
            left = 1,
            right = 3,
            x = 66,
            y = 0
        },
        {
            up = 2,
            down = 4,
            left = 7,
            right = nil,
            x = 132,
            y = 16
        },
        {
            up = 3,
            down = 5,
            left = 7,
            right = nil,
            x = 132,
            y = 48
        },
        {
            up = 7,
            down = nil,
            left = 6,
            right = 4,
            x = 66,
            y = 64
        },
        {
            up = 1,
            down = 5,
            left = nil,
            right = 7,
            x = 0,
            y = 48
        },
        {
            up = 2,
            down = 5,
            left = 1,
            right = 3,
            x = 66,
            y = 32
        }
    },
    init = function(self)
        -- pick space cards to slots
        for i, slot in pairs(self.slots) do
            local card = decks.PublicDeck:pickCards(1)
            self.slots[i].card = card
        end
    end,
    draw = function(self, imgMapSlot, x, y)
        for _, slot in pairs(self.slots) do
            setColor(white)
            love.graphics.draw(imgMapSlot, x + slot.x, y + slot.y)
            
            --space name
            setColor(black)
            love.graphics.printf(slot.card.space.name,
                    x + slot.x, y + slot.y + 31-2-fontSize, 96, 'center')
        end
    end
}