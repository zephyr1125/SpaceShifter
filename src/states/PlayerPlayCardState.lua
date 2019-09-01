function PlayerPlayCardState:enter()
    print("player state")
end

function PlayerPlayCardState:keypressed(key)
    if key == keys.DPad_right then
        player:selectPrev()
    end

    if key == keys.DPad_left then
        player:selectNext()
    end

    if key == keys.Y then
        player.cardAsAction = not player.cardAsAction
    end
    
    if key == keys.A then
        local needChooseSlot = player:playCard()
        if needChooseSlot then
            GameState.switch(PlayerChooseSlotState)
        else
            GameState.switch(ResolutionState)
        end
    end
end