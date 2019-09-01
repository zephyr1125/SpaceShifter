function PlayerChooseSlotState:enter()
    -- auto choose enemy slot
    local neighbourId = map:isNeighbour(player.slot, currentEnemy.slot)
    if neighbourId == 0 then
        player.targetSlot = player.slot
    else
        player.targetSlot = currentEnemy.slot
    end
end

function PlayerChooseSlotState:draw()
    
end