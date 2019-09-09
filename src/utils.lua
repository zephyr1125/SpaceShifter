function drawText(text, x, y, color)
    color = color or white
    setColor(color)
    love.graphics.print(text, x, y+3)
end

function setColor(color)
    color[4] = color[4] or 1
    love.graphics.setColor({color[1]/255, color[2]/255, color[3]/255, color[4]})
end

function drawFPS()
    setColor(white)
    love.graphics.print(tostring(love.timer.getFPS( )), 8, 8)
end

function drawLogs()
    setColor(white)
    for _,log in pairs(logs) do
        love.graphics.print(log, 8, 16)
    end
    
end

--Create card
function createRandomCard(scoreRange)
    --random action and space
    local action, space, totalScore
    repeat
        action = randomElement(actions)
        space = randomElement(spaces)
        totalScore = action.score + space.score
    until totalScore >= scoreRange[1] and totalScore <= scoreRange[2]
    
    local card = {action = action, space = space}
    return card
end

function fillAllDecks()
    for _, deck in pairs(decks) do
        deck.cards = {}
        for i = 1, deck.size do
            deck.cards[i] = createRandomCard(deck.scoreRange)
            deck.cards[i].deck = deck
        end
    end
end

function drawCardAsAction(card, x, y)
    setColor(cardActionColor)
    love.graphics.rectangle('fill', x, y, cardWidth, cardHeight)
    setColor(white)
    love.graphics.printf(card.action.name, x, y+cardHeight/2-fontSize, cardWidth, 'center')
end

function drawCardAsSpace(card, x, y)
    setColor(cardSpaceColor)
    love.graphics.rectangle('fill', x, y, cardWidth, cardHeight)
    setColor(white)
    love.graphics.printf(card.space.name, x, y+cardHeight/2-fontSize, cardWidth, 'center')
end

function reload(packageName)
    package.loaded[packageName] = nil
    return require(packageName)
end

function random(m, n)
    math.randomseed(os.time())
    return math.random(m,n)
end

function random(n)
    math.randomseed(os.time())
    return math.random(1,n)
end

-- random element in table, no mater if the table is integer sequence
function randomElement(myTable)
    -- iterate over whole table to get all keys
    local keySet = {}
    for k in pairs(myTable) do
        table.insert(keySet, k)
    end
    -- now you can reliably return a random key
    return myTable[keySet[math.random(#keySet)]]
end

function table.contains(tab, val)
    for _, value in pairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function table.clean(t)
    for k in pairs (t) do
        t [k] = nil
    end
end

function discardCard(card)
    local originDeck = card.deck
    originDeck.discardCards[#originDeck.discardCards+1] = card
end

function getLifePercent(char)
    return char.life/char.initLife
end

-- choose the first heal card from hand
function chooseHandCardHeal(char)
    for id, card in pairs(char.hand) do
        if table.contains(card.action.type, 'heal') then
            return id
        end
    end
    return 0
end

function chooseHandCardAttack(char)
    for id, card in pairs(char.hand) do
        if table.contains(card.action.type, 'attack') then
            return id
        end
    end
    return 0
end

function chooseHandCardMove(char)
    for id, card in pairs(char.hand) do
        if table.contains(card.action.type, 'move') then
            return id
        end
    end
    return 0
end