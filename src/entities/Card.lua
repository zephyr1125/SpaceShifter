Card = class{}

function Card:init(action, space, x, y)
    self.action = action
    self.space = space
    
    self.tweenWidth = 0
    self.isShowAction = true
    
    self.x = x
    self.y = y
end

function Card:draw()
    if self.isShowAction then
        self:drawCardAsAction()
    else
        self:drawCardAsSpace()
    end
end

function Card:drawCardAsAction()
    setColor(cardActionColor)
    love.graphics.rectangle('fill', self.x+self.tweenWidth/2, self.y,
            cardWidth-self.tweenWidth, cardHeight)
    setColor(white)
    love.graphics.printf(self.action.name, self.x, self.y+cardHeight/2-fontSize,
            cardWidth, 'center')
end

function Card:drawCardAsSpace()
    setColor(cardSpaceColor)
    love.graphics.rectangle('fill', self.x+self.tweenWidth/2, self.y,
            cardWidth-self.tweenWidth, cardHeight)
    setColor(white)
    love.graphics.printf(self.space.name, self.x, self.y+cardHeight/2-fontSize,
            cardWidth, 'center')
end

function Card:flip(caller, onFliped)
    flux.to(self, 0.1, {tweenWidth = cardWidth}):oncomplete(function()
        self.isShowAction = not self.isShowAction
        flux.to(self, 0.1, {tweenWidth = 0})
        if onFliped~= nil then onFliped(caller) end
    end)
end

function Card:moveTo(targetX, targetY, time)
    time = time or 0.4
    timer.tween(time, self, {x = targetX, y = targetY})
end