TutorialState = {}

function TutorialState:enter()
    isTutorialPlayed = true
    self.step = 1
end

function TutorialState:draw()
    setColor(white)
    if self.step == 1 then
        love.graphics.draw(imgTutorial1, 0, 0)
    elseif self.step == 2 then
        love.graphics.draw(imgTutorial2, 0, 0)
    end
end

function TutorialState:keypressed(key)
    if key == keys.A then
        self.step  = self.step + 1
        if self.step == 3 then
            GameState.pop()
        end
    end
end