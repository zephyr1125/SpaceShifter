local function drawDeck(cards, x, y, drawTopDeck)
    if #cards > 0 and drawTopDeck ~= nil then
        drawTopDeck(cards[#cards], x, y)
    end

    --card count
    setColor(white)
    love.graphics.printf(tostring(#cards), x, y+48, cardWidth, 'center')
end

local function refillDeck(self)
    for _, card in pairs(self.discardCards) do
        card.isShowAction = true
        table.add(self.cards, card)
    end
    table.clean(self.discardCards)
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
            table.add(picked, card)
        end
    end
    return picked
end

return {
    PublicDeck = {
        size = 40,
        scoreRange = {3,10},
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
    },
    GreedDeck = {
        size = 9,
        scoreRange = {3,4},
        discardCards = {},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end
    }
}