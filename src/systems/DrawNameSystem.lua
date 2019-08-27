DrawNameSystem = tiny.processingSystem()
DrawNameSystem.filter = tiny.requireAll('name')

function DrawNameSystem:process(e, dt)
    print(e.name)
end

return DrawNameSystem