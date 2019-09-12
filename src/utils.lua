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
        action = randomElement(actions.container)
        space = randomElement(spaces.container)
        totalScore = action.score + space.score
    until totalScore >= scoreRange[1] and totalScore <= scoreRange[2]
    
    local card = Card(action, space)
    return card
end

function fillAllDecks()
    fillDeck(decks.PublicDeck)
    fillDeck(decks.PlayerDeck)
    fillDeck(decks.BansheeDeck)
    fillDeck(decks.GreedDeck)
end

function fillDeck(deck)
    deck.cards = {}
    for i = 1, deck.size do
        deck.cards[i] = createRandomCard(deck.scoreRange)
        deck.cards[i].deck = deck
    end
end


function reload(packageName)
    package.loaded[packageName] = nil
    return require(packageName)
end

function random(m, n)
    --love.math.setRandomSeed(os.time())
    return love.math.random(m,n)
end

function random(n)
    --love.math.setRandomSeed(os.clock())
    return love.math.random(n)
end

-- random element in table, no mater if the table is integer sequence
function randomElement(myTable)
    -- iterate over whole table to get all keys
    local keySet = {}
    for k in pairs(myTable) do
        table.insert(keySet, k)
    end
    -- now you can reliably return a random key
    return myTable[keySet[random(#keySet)]]
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

function table.add(t, element)
    t[#t+1] = element
end

function discardCard(card)
    local originDeck = card.deck
    table.add(originDeck.discardCards, card)
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

function chooseHandCardDrop(char)
    for id, card in pairs(char.hand) do
        if table.contains(card.action.type, 'drop') then
            return id
        end
    end
    return 0
end

function dropFirstHandCard(char)
    if #char.hand == 0 then return end
    ---- if currently playing card, that card should not be droped
    if char.currentCardId ~= 0 and #char.hand == 1 then return end
    
    local dropId = 1
    if char.currentCardId == 1 then dropId = 2 end
    
    table.remove(char.hand,dropId)
end

function sortDeck(deck)
    table.sort(deck.cards, function(e1, e2)
        return e1.action.score+e1.space.score < e2.action.score+e2.space.score
    end)
end

-- moveMode: 'instant', 'fly', 'hit'
function charMove(char, newSlot, moveMode, onComplete)
    local newX = map.slots[newSlot].x
            + math.floor(mapSlotWidth/2) - char.spriteWidth/2
    local newY = map.slots[newSlot].y
            + math.floor(mapSlotHeight/2) - char.spriteHeight
    if moveMode == 'instant' then
        char.x = newX
        char.y = newY
        if onComplete ~= nil then onComplete() end
    elseif moveMode == 'fly' then
        flux.to(char, 0.5, {x=newX, y=newY}):ease('quintout'):oncomplete(onComplete)
    elseif moveMode == 'hit' then
        flux.to(char, 0.25, {x=newX, y=newY}):ease('quintout'):oncomplete(onComplete)
    end
end