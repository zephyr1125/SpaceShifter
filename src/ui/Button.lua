local Button = class {}

function Button:init(text, width, height, idleBGColor, selectBGColor, confirmCallback)
    self.text = text
    self.width = width
    self.height = height
    self.idleBGColor = idleBGColor
    self.selectBGColor = selectBGColor
    self.confirmCallback = confirmCallback
    
    self.textWidth = love.graphics.getFont():getWidth(text)
end

function Button:setSelect(isSelect)
    self.isSelect = isSelect
end

function Button:draw(x, y)
    -- move cursor
    if self.isSelect then
        cursor:moveTo(x+self.width/2+12, y+self.height-4)
    end
    
    -- idle background
    if self.idleBGColor and not self.isSelect then
        setColor(self.idleBGColor)
        love.graphics.rectangle('fill', x,y, self.width,self.height)
    end
    
    -- selected background
    if self.selectBGColor and self.isSelect then
        setColor(self.selectBGColor)
        love.graphics.rectangle('fill', x,y, self.width,self.height)
    end
    
    --text
    setColor(white)
    love.graphics.printf(self.text, x, y+2, self.width, 'center')
end

function Button:keypressed(key)
    if key == keys.A and self.isSelect then
        self.confirmCallback()
    end
end

return Button