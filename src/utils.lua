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
function createRandomCard(scoreRange, x, y)
    --random action and space
    local action, space, totalScore
    repeat
        action = randomElement(actions.container)
        space = randomElement(spaces.container)
        totalScore = action.score + space.score
    until totalScore >= scoreRange[1] and totalScore <= scoreRange[2]
    
    local card = Card(action, space, x, y)
    return card
end

function fillAllDecks()
    fillDeck(decks.PublicDeck)
    fillDeck(decks.PlayerDeck)
    fillDeck(decks.BansheeDeck)
    fillDeck(decks.GhostDeck)
    fillDeck(decks.TrollDeck)
end

function fillDeck(deck)
    for i = 1, deck.size do
        if i>#deck.cards then
            deck.cards[i] = createRandomCard(deck.scoreRange, deck.x, deck.y)
        else
            deck.cards[i].x = deck.x
            deck.cards[i].y = deck.y
        end
        deck.cards[i].deck = deck
    end
    -- shuffle the deck
    shuffle(deck.cards)
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
function randomElement(myTable, except)
    -- iterate over whole table to get all keys
    local keySet = {}
    for k in pairs(myTable) do
        table.insert(keySet, k)
    end
    -- now you can reliably return a random key
    local result
    repeat
        result = myTable[keySet[random(#keySet)]]
    until result ~= except
    return result
end

function table.contains(tab, val)
    for _, value in pairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function table.find(tab, val)
    for i, value in pairs(tab) do
        if value == val then
            return i
        end
    end

    return 0
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
    if originDeck ~= nil then originDeck:discardCard(card) end
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

function chooseHandCardSpaceRecover(char)
    for id, card in pairs(char.hand) do
        if table.contains(card.action.type, 'spaceRecover') then
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

    discardCard(char.hand[dropId])
    table.remove(char.hand, dropId)
end

function sortDeck(deck)
    table.sort(deck.cards, function(e1, e2)
        return e1.action.score+e1.space.score < e2.action.score+e2.space.score
    end)
end

-- moveMode: 'instant', 'fly', 'hit', 'jump', 'arrive'
function charMove(char, newSlot, moveMode, onComplete)
    char.slot = newSlot
    
    local newX = map.slots[newSlot].x
            + math.floor(mapSlotWidth/2) - char.spriteWidth/2
    local newY = map.slots[newSlot].y
            + math.floor(mapSlotHeight/2) - char.spriteHeight
    if moveMode == 'instant' then
        char.x = newX
        char.y = newY
        if onComplete ~= nil then onComplete() end
    elseif moveMode == 'fly' then
        timer.tween(0.5, char, {x=newX, y=newY}, 'out-quint', onComplete)
    elseif moveMode == 'hit' then
        timer.tween(0.25, char, {x=newX, y=newY}, 'out-quint', onComplete)
    elseif moveMode == 'jump' then
        local time = 0.8
        timer.tween(time, char, {x=newX}, 'out-in-cubic', onComplete)
        local yTop = (char.y + newY)/2 - 80
        timer.tween(time/2, char, {y=yTop}, 'out-cubic', function()
            timer.tween(time/2, char, {y=newY}, 'in-cubic')
        end)
    elseif moveMode == 'arrive' then
        char.x = newX
        char.y = newY - 120
        timer.tween(0.8, char, {x=newX, y=newY}, 'out-quint', onComplete)
    end
end

function drawTip(char, tip)
    if tip.y ~= tip.baseY then
        setColor(white)
        love.graphics.draw(tip.img, mapX + char.x + tip.x,
                mapY + char.y + tip.y)
        love.graphics.setFont(fontNum)
        love.graphics.print((tip.value>0 and '+' or '')..tostring(tip.value),
                mapX + char.x + tip.x + 6, mapY + char.y + tip.y + 4)
        love.graphics.setFont(fontCN)
    end
end

function changeLife(char, value)
    char.life = char.life + value
    if value > 0 then
        -- show heal tip
        char.healTip.value = value
        timer.tween(1, char.healTip, {y = char.healTip.baseY - 16}, 'out-cubic',
                function() char.healTip.y = char.healTip.baseY end)
    elseif value < 0 then
        -- shake of damage
        char.isShaking = true
        timer.after(0.4, function() char.isShaking = false end)
        -- show damage tip
        char.damageTip.value = value
        timer.tween(1, char.damageTip, {y = char.damageTip.baseY - 16}, 'out-cubic',
                function() char.damageTip.y = char.damageTip.baseY end)
    end
end

function isPlayingDefence(char)
    return char.playingCardAsAction and
        table.contains(char.playingCard.action.type, 'defence')
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function floatequal(left,right,precision)
    local diff = math.abs(left-right)
    return diff < precision
end

function shuffle(list)
    for i = #list, 2, -1 do
        local j = random(i)
        list[i], list[j] = list[j], list[i]
    end
end