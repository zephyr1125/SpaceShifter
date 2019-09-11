local function checkTargetSlot(playerNeighbours, slot)
    local isNeighbour = slot ~= 0 and table.contains(playerNeighbours, slot)
    -- playing space only consider if is neighbour
    if not player.playingCardAsAction then return isNeighbour end
    -- playing action need to consider exception
    local action = player.playingCard.action
    return isNeighbour and slot ~= action.getExceptSlot(player, currentEnemy)
end

local function setTargetSlot(playerNeighbours, slot)
    if checkTargetSlot(playerNeighbours, slot) then
        player.targetSlot = slot
    end
end

PlayerChooseSlotState = {}

function PlayerChooseSlotState:init()
    
end

function PlayerChooseSlotState:enter()
    -- to defaultSlot
    if player.playingCardAsAction then
        player.targetSlot = player.playingCard.action.defaultTargetSlot(player, currentEnemy)
    else
        player.targetSlot = player.playingCard.space.defaultTargetSlot(player, currentEnemy)
    end
    infoBar:setCardInfo(map.slots[player.targetSlot].card, false)
end

function PlayerChooseSlotState:draw()
    local slot = map.slots[player.targetSlot]
    
    setColor(white)
    love.graphics.draw(imgSlotSelect, mapX + slot.x, mapY + slot.y)
end

function PlayerChooseSlotState:keypressed(key)
    if key == keys.B then
        GameState.switch(PlayerPlayCardState)
        return
    end
    
    local playerNeighbours = map:getNeighbours(player.slot)
    playerNeighbours[#playerNeighbours+1] = player.slot
    local next
    if key == keys.DPad_up then
        next = map:getNeighbours(player.targetSlot)[1]
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[6]
        end
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[2]
        end
        setTargetSlot(playerNeighbours, next)
    elseif key == keys.DPad_down then
        next = map:getNeighbours(player.targetSlot)[4]
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[5]
        end
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[3]
        end
        setTargetSlot(playerNeighbours, next)
    elseif key == keys.DPad_left then
        next = map:getNeighbours(player.targetSlot)[6]
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[5]
        end
        setTargetSlot(playerNeighbours, next)
    elseif key == keys.DPad_right then
        next = map:getNeighbours(player.targetSlot)[2]
        if not checkTargetSlot(playerNeighbours, next) then
            next = map:getNeighbours(player.targetSlot)[3]
        end
        setTargetSlot(playerNeighbours, next)
    end

    if key == keys.A then
        GameState.switch(ResolutionState)
        return
    end

    infoBar:setCardInfo(map.slots[player.targetSlot].card, false)
end