return {
    slots = {
        {
            neighbours = {0, 2, 7, 6, 0, 0},
            x = 0,
            y = 16
        },
        {
            neighbours = {0, 0, 3, 7, 1, 0},
            x = 66,
            y = 0
        },
        {
            neighbours = {0, 0, 0, 4, 7, 2},
            x = 132,
            y = 16
        },
        {
            neighbours = {3, 0, 0, 0, 5, 7},
            x = 132,
            y = 48
        },
        {
            neighbours = {7, 4, 0, 0, 0, 6},
            x = 66,
            y = 64
        },
        {
            neighbours = {1, 7, 5, 0, 0, 0},
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
    getNeighbours = function(self, slot)
        if slot < 1 or slot > #self.slots then return {} end
        return {unpack(self.slots[slot].neighbours)}
    end,
    getNoHoleNeighbours = function(self, slot)
        --warning remove the 0s of neighbours table but be aware will loss direction information
        local neighbours = self:getNeighbours(slot)
        for i=#neighbours,1,-1 do
            if neighbours[i] == 0 then
                table.remove(neighbours, i)
            end
        end
        return neighbours
    end,
    randomNeighbour = function(self, slot, except)
        local neighbours = self:getNoHoleNeighbours(slot)
        -- remove the except slot
        for i, neighbour in pairs(neighbours) do
            if neighbour == except then table.remove(neighbours, i) end
        end
        return neighbours[random(#neighbours)]
    end
}