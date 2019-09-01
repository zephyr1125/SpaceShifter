function PlayerPlayCardState:enter()
    print("player state")
end

function PlayerPlayCardState:keypressed(key)
    if key == keys.A then
        local needChooseSlot = player:playCard()
        if needChooseSlot then
            GameState.switch(PlayerChooseSlotState)
        else
            GameState.switch(ResolutionState)
        end
    end
end