function PlayerChooseSlotState:init()
    self.imgSelect = love.graphics.newImage('assets/images/slot_select.png')
end

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
    local slot = map.slots[player.targetSlot]
    
    setColor(white)
    love.graphics.draw(self.imgSelect, mapX + slot.x, mapY + slot.y)
end