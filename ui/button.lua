local class = require('lib.hump.class')

local Button = class {}

function Button:init(text, width, height, bgImage)
    self.text = text
    self.width = width
    self.height = height
    self.bgImage = bgImage
    self.textWidth = love.graphics.getFont():getWidth(text)
end

function Button:draw(x, y)
    --text
    love.graphics.print(self.text, x + math.floor((self.width-self.textWidth)/2), y)
end

return Button