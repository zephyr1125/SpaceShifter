local InfoBar = class {}

function InfoBar:init(width)
    self.width = width
end

function InfoBar:setText(text)
    self.text = text
end

function InfoBar:setCardInfo(card, isAction)
    if isAction then
        self.text = card.action.info
    else
        self.text = card.space.info
    end
end

function InfoBar:draw(x, y)
    setColor(infoBarBgColor)
    love.graphics.rectangle('fill', x, y, self.width, 20)
    
    if self.text == nil then return end
    setColor(infoBarTextColor)
    love.graphics.print(self.text, x+4, y+4)
end

return InfoBar