local function drawDeck(cards, x, y, drawTopDeck)

    setColor({136, 151, 166})
    love.graphics.rectangle('line', x, y, cardWidth, cardHeight)

    if drawTopDeck ~= nil then drawTopDeck() end

    --card count
    setColor(white)
    love.graphics.printf(tostring(#cards), x, y+48, cardWidth, 'center')
end

local function pickCards(cards, target, amount)
    target = target or {}
    for _ = 1, amount do
        local card = table.remove(cards, #cards)
        target[#target+1] = card
    end
end

return {
    PublicDeck = {
        size = 40,
        scoreRange = {4,10},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y, drawCardAsSpace(self.cards[#self.cards], x, y))
        end,
        pickCards = function(self, target, amount)
            pickCards(self.cards, target, amount)
        end
    },
    PlayerDeck = {
        size = 9,
        scoreRange = {2,2},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y, drawCardAsAction(self.cards[#self.cards], x, y))
        end,
        pickCards = function(self, target, amount)
            pickCards(self.cards, target, amount)
        end
    },
    BansheeDeck = {
        size = 9,
        scoreRange = {2,3},
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, target, amount)
            pickCards(self.cards, target, amount)
        end
    }
}