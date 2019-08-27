require('utils')
local class = require('lib.hump.class')

local Button = class {}

function Button:init(text, width, height, idleBGColor, selectBGColor, confirmBGColor)
    self.text = text
    self.width = width
    self.height = height
    self.idleBGColor = idleBGColor
    self.selectBGColor = selectBGColor
    self.confirmBGColor = confirmBGColor
    self.textWidth = love.graphics.getFont():getWidth(text)
end

function Button:setSelect(isSelect)
    self.isSelect = isSelect
end

function Button:draw(x, y)
    if self.idleBGColor then
        love.graphics.setColor(self.idleBGColor)
        love.graphics.rectangle('fill', x,y, self.width,self.height)
    end
    --text
    drawText(self.text, x + math.floor((self.width-self.textWidth)/2), y, {1,1,1})
end

return Button