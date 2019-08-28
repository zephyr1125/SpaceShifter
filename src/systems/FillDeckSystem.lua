FillDeckSystem = tiny.processingSystem()
FillDeckSystem.filter = tiny.requireAll('size', 'score', tiny.rejectAll('cards'))

function FillDeckSystem:process(e, dt)
    e.cards = {}
    e.cards[1] = createRandomCard(e.score, world)
    for i = 1, e.size do
        e.cards[i] = createRandomCard(e.score, world)
    end
end

return FillDeckSystem