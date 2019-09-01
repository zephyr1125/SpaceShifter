function PlayerActionState:enter()
    print("player state")
end

function PlayerActionState:keypressed(key)
    if key == keys.A then
        player:playCard()
        GameState.switch(ResolutionState)
    end
end