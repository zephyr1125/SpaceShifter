local function drawDeck(cards, x, y, drawTopDeck)

    setColor({136, 151, 166})
    love.graphics.rectangle('line', x, y, cardWidth, cardHeight)

    if #cards > 0 and drawTopDeck ~= nil then
        drawTopDeck(cards[#cards], x, y)
    end

    --card count
    setColor(white)
    love.graphics.printf(tostring(#cards), x, y+48, cardWidth, 'center')
end

local function refillDeck(self)
    for i, _ in pairs(self.discardCards) do
        self.cards[#self.cards+1] = table.remove(self.discardCards, i)
    end
    print('refilled deck')
end

-- if amount == 1 return 1 card, else return table of cards
local function pickCards(self, amount)
    if #self.cards == 0 then
        refillDeck(self)
    end
    local picked = {}
    for _ = 1, amount do
        local card = table.remove(self.cards, #self.cards)
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
            drawDeck(self.cards, x, y, drawCardAsSpace)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end
    },
    PlayerDeck = {
        size = 12,
        scoreRange = {2,2},
        discardCards = {},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y, drawCardAsAction)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
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
            return pickCards(self, amount)
        end
    }
}