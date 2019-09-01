return {
    slots = {
        {
            neighbours = {nil, 2, 7, 6, nil, nil},
            x = 0,
            y = 16
        },
        {
            neighbours = {nil, nil, 3, 7, 1, nil},
            x = 66,
            y = 0
        },
        {
            neighbours = {nil, nil, nil, 4, 7, 2},
            x = 132,
            y = 16
        },
        {
            neighbours = {3, nil, nil, nil, 5, 7},
            x = 132,
            y = 48
        },
        {
            neighbours = {7, 4, nil, nil, nil, 6},
            x = 66,
            y = 64
        },
        {
            neighbours = {1, 7, 5, nil, nil, nil},
            right = 7,
            x = 0,
            y = 48
        },
        {
            neighbours = {2, 3, 4, 5, 6, 1},
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
    end,
    -- returns neighbour id starts with 1 at up, and counter clockwise
    -- returns 0 if is not neighbour
    isNeighbour = function (self, a, b)
        for i, neighbour in pairs(self.slots[a].neighbours) do
            if neighbour == b then return i end
        end
        return 0
    end,
    getNeighbour = function(self, slot)
        if slot > #self.slots then return {} end
        return self.slots[slot].neighbours
    end,
}