local function drawDeck(cards, x, y, drawTopDeck)

    setColor({136, 151, 166})
    love.graphics.rectangle('line', x, y, cardWidth, cardHeight)

    if drawTopDeck ~= nil then drawTopDeck() end

    --card count
    setColor(white)
    love.graphics.printf(tostring(#cards), x, y+48, cardWidth, 'center')
end

-- if amount == 1 return 1 card, else return table of cards
local function pickCards(cards, amount)
    local picked = {}
    for _ = 1, amount do
        local card = table.remove(cards, #cards)
        if amount == 1 then
            return card
        else
            picked[#picked+1] = card
        end
    end
    return picked
end

return {
    PublicDeck = {
        size = 40,
        scoreRange = {4,10},
        discardCards = {},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y, drawCardAsSpace(self.cards[#self.cards], x, y))
        end,
        pickCards = function(self, amount)
            return pickCards(self.cards, amount)
        end
    },
    PlayerDeck = {
        size = 9,
        scoreRange = {2,2},
        discardCards = {},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y, drawCardAsAction(self.cards[#self.cards], x, y))
        end,
        pickCards = function(self, amount)
            return pickCards(self.cards, amount)
        end
    },
    BansheeDeck = {
        size = 9,
        scoreRange = {2,3},
        discardCards = {},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, amount)
            return pickCards(self.cards, amount)
        end
    }
}