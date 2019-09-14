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
    setColor(white)
    -- bg
    love.graphics.draw(imgCardActionBg, self.x+self.tweenWidth/2, self.y, 0,
        1-(self.tweenWidth/cardWidth), 1)
    
    setColor(black)
    love.graphics.printf(self.action.name, self.x, self.y+cardHeight/2-fontSize,
            cardWidth, 'center')
end

function Card:drawCardAsSpace()
    setColor(white)
    -- bg
    love.graphics.draw(imgCardSpaceBg, self.x+self.tweenWidth/2, self.y, 0,
            1-(self.tweenWidth/cardWidth), 1)
    
    -- icon
    love.graphics.draw(self.space.icon, self.x+self.tweenWidth/2+4, self.y+4, 0,
            1-(self.tweenWidth/cardWidth), 1)
    
    -- effect
    love.graphics.draw(self.space.effectIcon, self.x+self.tweenWidth/2+4, self.y+40, 0,
            1-(self.tweenWidth/cardWidth), 1)
end

function Card:flip(caller, onFliped)
    flux.to(self, 0.1, {tweenWidth = cardWidth}):oncomplete(function()
        self.isShowAction = not self.isShowAction
        flux.to(self, 0.1, {tweenWidth = 0})
        if onFliped~= nil then onFliped(caller) end
    end)
end

function Card:moveTo(targetX, targetY, time, onComplete)
    time = time or 0.4
    --print(self.action.name..'|'..tostring(self.deck)..' move to '..tostring(targetX)..','..tostring(targetY))
    timer.tween(time, self, {x = targetX, y = targetY}, 'linear', onComplete)
end