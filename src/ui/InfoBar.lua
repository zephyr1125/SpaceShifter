local InfoBar = class {}

function InfoBar:init(width)
    self.width = width
    self.isShowFlipInfo = false
end

function InfoBar:setText(text)
    self.text = text
end

function InfoBar:setCardInfo(card)
    if card.isShowAction then
        self.text = card.action.info
    else
        self.text = card.space.info
    end
end

function InfoBar:setShowFlipInfo(isShowFlipInfo)
    self.isShowFlipInfo = isShowFlipInfo
end

function InfoBar:draw(x, y)
    setColor(infoBarBgColor)
    love.graphics.rectangle('fill', x, y, self.width, 20)
    
    -- button y flip card
    if self.isShowFlipInfo then
        setColor(white)
        love.graphics.draw(imgButtonY, x+246, y+4)
        setColor(infoBarFlipInfoColor)
        love.graphics.print(i18n.flipCard, x+258, y+4)
    end
    
    
    if self.text == nil then return end
    setColor(infoBarTextColor)
    love.graphics.print(self.text, x+4, y+4)
end

return InfoBar