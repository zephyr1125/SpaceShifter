local function checkTargetSlot(playerNeighbours, slot)
    local action = player.playingCard.action
    return slot ~= 0 and hasValue(playerNeighbours, slot)
            and slot ~= action.getExceptSlot(player, currentEnemy)
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
    player.targetSlot = player.playingCard.action.defaultTargetSlot(player, currentEnemy)
end

function PlayerChooseSlotState:draw()
    local slot = map.slots[player.targetSlot]
    
    setColor(white)
    love.graphics.draw(imgSlotSelect, mapX + slot.x, mapY + slot.y)
end

function PlayerChooseSlotState:keypressed(key)
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
    end
end