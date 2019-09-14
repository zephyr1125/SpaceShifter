local Map = class {
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
    init = function(self, onComplete)
        -- pick space cards to slots
        for i, slot in pairs(self.slots) do
            local card = decks.PublicDeck:pickCards(1)
            card.isShowAction = false
            self.slots[i].baseCard = card
            self.slots[i].card = card
            timer.after(i*0.3, function()
                local callback = (i == #self.slots) and onComplete or nil
                card:moveTo(mapX+slot.x+28, mapY+slot.y-12, 0.3, callback, 'out-cubic')
            end)
        end
    end,
    draw = function(self, imgMapSlot, x, y)
        local sequence = {2,1,3,7,6,4,5}
        for _, slotId in pairs(sequence) do
            local slot = map.slots[slotId]
            setColor(white)

            if not floatequal(slot.card.y, mapY+slot.y-12, 0.1) then
                --space card
                slot.card:draw()
            else
                -- space chess
                love.graphics.draw(slot.card.space.chess, x + slot.x, y + slot.y-8)
            end
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
    end,
    getSlotOccupied = function(self, slot)
        local resident
        if player.slot == slot then resident = player end
        if currentEnemy~=nil and currentEnemy.slot == slot then resident = currentEnemy end
        return resident
    end,
    getBestBenefitNeighbour = function (self, slot, isExceptOccupied)
        isExceptOccupied = isExceptOccupied or true
        local mostBenefit = self.slots[slot].card.space.benefit
        local mostSlot = slot
        for _, neighbour in pairs(self:getNoHoleNeighbours(slot)) do
            local skip = isExceptOccupied and self:getSlotOccupied(neighbour)~=nil
            local benefit = self.slots[neighbour].card.space.benefit
            if benefit > mostBenefit and not skip then
                mostBenefit = benefit
                mostSlot = neighbour
            end
        end
        return mostSlot
    end,
    shiftSpace = function(self, slotId, newCard)
        local slot = self.slots[slotId]
        newCard = newCard or slot.baseCard
        local oldCard = slot.card
        if oldCard ~= slot.baseCard then
            discardCard(oldCard)
        end
        slot.card = newCard
        newCard:moveTo(mapX+ slot.x+28, mapY+ slot.y-12, 0.3, nil, 'out-cubic')
    end
}
return Map