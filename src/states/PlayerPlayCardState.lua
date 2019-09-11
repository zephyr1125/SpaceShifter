PlayerPlayCardState = {}
function PlayerPlayCardState:enter()
    print("player state")
    player.currentCardId = #player.hand
    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end

function PlayerPlayCardState:keypressed(key)
    if key == keys.B then
        -- todo open system window
        screenManager:view('/')
    end
    
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

    infoBar:setCardInfo(player.hand[player.currentCardId], player.cardAsAction)
end