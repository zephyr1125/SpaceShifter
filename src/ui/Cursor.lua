local Cursor = class {}

local defaultX = -60
local defaultY = -60

function Cursor:init(x, y)
    self.x = x or defaultX
    self.y = y or defaultY
    self.isTweening = false
    self.visible = true
    self.isTip = false
end

function Cursor:setVisible(visible)
    self.visible = visible
end

function Cursor:setTip(isTip)
    self.isTip = isTip
end

function Cursor:moveTo(x, y)
    if not self.isTweening and
        (not floatequal(self.x, x, 1) or not floatequal(self.y, y, 1)) then
        self.isTweening = true
        timer.tween(0.1, self, {x = x, y = y}, 'linear', function()
            self.isTweening = false
        end)
    end
end

function Cursor:moveToCard(card)
    self:moveTo(card.x+cardWidth/2, card.y+cardHeight-4)
end

function Cursor:moveToMapSlot(slotId)
    local slot = map.slots[slotId]
    self:moveTo(mapX + slot.x + 48, mapY + slot.y + 26)
end

function Cursor:onMoveDone()
    self.isTweening = false
end

function Cursor:draw()
    if not self.visible then return end
    setColor(white)
    local img = self.isTip and imgTipCursor or imgCursor
    love.graphics.draw(img, self.x, self.y)
end

return Cursor