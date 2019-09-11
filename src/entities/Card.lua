local function drawCardAsAction(self, x, y)
    setColor(cardActionColor)
    love.graphics.rectangle('fill', x+self.tweenWidth/2, y,
            cardWidth-self.tweenWidth, cardHeight)
    setColor(white)
    love.graphics.printf(self.action.name, x, y+cardHeight/2-fontSize, cardWidth, 'center')
end

local function drawCardAsSpace(self, x, y)
    setColor(cardSpaceColor)
    love.graphics.rectangle('fill', x+self.tweenWidth/2, y,
            cardWidth-self.tweenWidth, cardHeight)
    setColor(white)
    love.graphics.printf(self.space.name, x, y+cardHeight/2-fontSize, cardWidth, 'center')
end

Card = class{}

function Card:init(action, space)
    self.action = action
    self.space = space
    
    self.tweenWidth = 0
    self.isShowAction = true
end

function Card:draw(x, y)
    if self.isShowAction then
        drawCardAsAction(self, x, y)
    else
        drawCardAsSpace(self, x, y)
    end
end

function Card:flip()
    flux.to(self, 0.1, {tweenWidth = cardWidth}):oncomplete(function()
        self.isShowAction = not self.isShowAction
        flux.to(self, 0.1, {tweenWidth = 0})
    end)
end