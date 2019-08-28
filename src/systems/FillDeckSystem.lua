FillDeckSystem = tiny.processingSystem()
FillDeckSystem.filter = tiny.requireAll('size', 'score', tiny.rejectAll('cards'))

function FillDeckSystem:process(e, dt)
    e.cards = 2
end

return FillDeckSystem