ResolutionState = {}

function ResolutionState:enter()
    self:reset()

    self.step = 'cardMove'
    
    self:cardsMove()
end

function ResolutionState:cardsMove()
    player:hideUnplayedHandCards(function()
            self.isCardMoveDone = true
    end)
end

function ResolutionState:playFX(playerAction, enemyAction)
    if playerAction.sprite ~= nil then
        self.playerFX = peachy.new(playerAction.sprite[1],
            love.graphics.newImage(playerAction.sprite[2]), playerAction.sprite[3])
        self.playerFX:play()
        self.playerFX:onLoop(function()
            self.playerFX:stop()
            self.isPlayerFXDone = true
        end)
    else
        self.isPlayerFXDone = true
    end
    if playerAction.sound ~= nil then
        playerAction.sound:play()
    end

    if enemyAction.sprite ~= nil then
        self.enemyFX = peachy.new(enemyAction.sprite[1],
            love.graphics.newImage(enemyAction.sprite[2]), enemyAction.sprite[3])
        self.enemyFX:play()
        self.enemyFX:onLoop(function()
            self.enemyFX:stop()
            self.isEnemyFXDone = true
        end)
    else
        self.isEnemyFXDone = true
    end
    if enemyAction.sound ~= nil then
        enemyAction.sound:play()
    end
end

function ResolutionState:draw()
    if self.playerFX ~= nil and not self.isPlayerFXDone then
        self:drawFX(player, self.playerFX)
    end
    if self.enemyFX ~= nil and not self.isEnemyFXDone then
        self:drawFX(currentEnemy, self.enemyFX)
    end

    if self.playerSFX ~= nil and not self.isPlayerEffectDone then
        self:drawEffect(self.playerSFX)
    end

    if self.enemySFX ~= nil and not self.isEnemyEffectDone then
        self:drawEffect(self.enemySFX)
    end
    
    if self.playerDefenceFX ~= nil and not self.isPlayerDefenceFXDone then
        self:drawDefenceFX(player, self.playerDefenceFX)
    end
    if self.enemyDefenceFX ~= nil and not self.isEnemyDefenceFXDone then
        self:drawDefenceFX(currentEnemy, self.enemyDefenceFX)
    end
end

function ResolutionState:drawFX(char, spriteFX)
    local spriteX, spriteY, drawSlot
    if char.targetSlot == 0 then
        drawSlot = char.slot
    else
        drawSlot = char.targetSlot
    end
    spriteX = mapX + map.slots[drawSlot].x + mapSlotWidth/2 - spriteFX:getWidth()/2
    spriteY = mapY + map.slots[drawSlot].y + 4 - spriteFX:getHeight()/2
    spriteFX:draw(spriteX, spriteY)
end

function ResolutionState:drawEffect(sfx)
    if sfx == nil then return end
    
    setColor(white)
    love.graphics.draw(sfx.img, mapX + sfx.x, mapY + sfx.y)
end

function ResolutionState:drawDefenceFX(char, spriteDefenceFX)
    local spriteX, spriteY
    spriteX = mapX + map.slots[char.slot].x + mapSlotWidth/2 - spriteDefenceFX:getWidth()/2
    spriteY = mapY + map.slots[char.slot].y + 4 - spriteDefenceFX:getHeight()/2
    spriteDefenceFX:draw(spriteX, spriteY)
end

function ResolutionState:update(dt)
    if self.playerFX ~= nil then
        self.playerFX:update(dt)
    end
    if self.enemyFX ~= nil then
        self.enemyFX:update(dt)
    end
    if self.playerDefenceFX ~= nil then
        self.playerDefenceFX:update(dt)
    end
    if self.enemyDefenceFX ~= nil then
        self.enemyDefenceFX:update(dt)
    end
    
    if self.step == 'cardMove' and self.isCardMoveDone then
        self.step = 'effect'
        local playerAction = player.playingCard.action
        local playerSpace = player.playingCard.space
        local enemyAction = currentEnemy.playingCard.action
        local enemySpace = currentEnemy.playingCard.space
        self:playFX(playerAction, enemyAction)
        -- shift space first
        self:shiftSpace()
        -- then move
        self:move(playerAction, enemyAction)
        self:cardsEffect(playerAction, enemyAction)
    elseif self.step == 'effect' and self.isPlayerShiftSpaceDone 
            and self.isPlayerEffectDone and self.isEnemyEffectDone then
        self.step = 'damage'
    elseif self.step == 'damage' then
        self.onAttack()
        self.extraDefence()
        local isPlayerAttackSuccess, isEnemyAttackSuccess = self.calcDamage()
        self:playDefence(isPlayerAttackSuccess, isEnemyAttackSuccess)
        self.step = 'done'
    elseif self.step == 'done' then
        self:done()
    end
end

function ResolutionState:done()
    if self.isPlayerFXDone and self.isEnemyFXDone and
            self.isPlayerMoveDone and self.isEnemyMoveDone and
            self.isPlayerDefenceFXDone and self.isEnemyDefenceFXDone and
            self.isPlayerEffectDone and self.isEnemyEffectDone
    then
        self.cleanCards()
        -- next state
        GameState.switch(UpkeepState)
    end
end

function ResolutionState:move(playerAction, enemyAction)
    -- if they are moving to same slot, stop both
    if currentEnemy.playingCardAsAction and enemyAction.move ~= nil and
            player.playingCardAsAction and playerAction.move ~= nil and
            currentEnemy.targetSlot == player.targetSlot then
        -- todo play some collide animation then set move done
    else
        if currentEnemy.playingCardAsAction and enemyAction.move ~= nil then
            enemyAction.move(currentEnemy, function()
                    self.isEnemyMoveDone = true
            end)
        else
            self.isEnemyMoveDone = true
        end
        if player.playingCardAsAction and playerAction.move ~= nil then
            playerAction.move(player, function()
                    self.isPlayerMoveDone = true
            end)
        else
            self.isPlayerMoveDone = true
        end
    end
end

function ResolutionState:cardsEffect(playerAction, enemyAction)
    if player.playingCardAsAction and playerAction.effect ~= nil then
        if playerAction.sfxImg ~= nil then
            self.playerSFX = {x=0, y=0, img = playerAction.sfxImg}
        end
        playerAction:effect(player, currentEnemy, self.playerSFX, function()
                self.isPlayerEffectDone = true
        end)
    else
        self.isPlayerEffectDone = true
    end
    if currentEnemy.playingCardAsAction and enemyAction.effect ~= nil then
        if enemyAction.sfxImg ~= nil then
            self.enemySFX = {x=0, y=0, img = enemyAction.sfxImg}
        end
        enemyAction:effect(currentEnemy, player, self.enemySFX, function()
            self.isEnemyEffectDone = true
        end)
    else
        self.isEnemyEffectDone = true
    end
end

function ResolutionState.onAttack()
    if table.contains(player.playingCard.action.type, 'attack') then
        local isHit = player.targetSlot == currentEnemy.slot
        local space = map.slots[player.slot].card.space
        if isHit and space.onAttack~= nil then space.onAttack(player, currentEnemy) end
    end

    if table.contains(currentEnemy.playingCard.action.type, 'attack') then
        local isHit = currentEnemy.targetSlot == player.slot
        local space = map.slots[currentEnemy.slot].card.space
        if isHit and space.onAttack~= nil then space.onAttack(currentEnemy, player) end
    end
end

function ResolutionState.extraDefence()
    local playerAtSpace = map.slots[player.slot].card.space
    if playerAtSpace.onCalcDefence ~= nil then
        playerAtSpace.onCalcDefence(player, currentEnemy)
    end
    local enemyAtSpace = map.slots[currentEnemy.slot].card.space
    if enemyAtSpace.onCalcDefence ~= nil then
        enemyAtSpace.onCalcDefence(currentEnemy, player)
    end
end

function ResolutionState.calcDamage()
    -- not correct slot, no damage
    local isPlayerAttackSuccess =
    player.targetSlot ~= nil and player.targetSlot == currentEnemy.slot
    local isEnemyAttackSuccess =
    currentEnemy.targetSlot ~= nil and currentEnemy.targetSlot == player.slot

    -- calc damage
    if isPlayerAttackSuccess then
        currentEnemy.damagePending = currentEnemy.damagePending + player.attack
    end
    currentEnemy.damagePending = currentEnemy.damagePending - currentEnemy.defence
    if isEnemyAttackSuccess then
        player.damagePending = player.damagePending + currentEnemy.attack
    end
    player.damagePending = player.damagePending - player.defence

    -- trim damage
    if currentEnemy.damagePending<0 then currentEnemy.damagePending = 0 end
    if player.damagePending<0 then player.damagePending = 0 end

    -- space onDamaged
    local enemySpace = map.slots[currentEnemy.slot].card.space
    if currentEnemy.damagePending > 0 and enemySpace.onDamaged ~= nil then
        enemySpace.onDamaged(currentEnemy)
    end
    local playerSpace = map.slots[player.slot].card.space
    if player.damagePending > 0 and playerSpace.onDamaged ~= nil then
        playerSpace.onDamaged(player)
    end

    -- resolve damage
    currentEnemy:changeLife(-currentEnemy.damagePending)
    player:changeLife(-player.damagePending)
    
    return isPlayerAttackSuccess, isEnemyAttackSuccess
end

function ResolutionState:playDefence(isPlayerAttackSuccess, isEnemyAttackSuccess)
    if isPlayingDefence(player) or (player.defence>0 and isEnemyAttackSuccess) then
        if self.playerDefenceFX == nil then
            self.playerDefenceFX = peachy.new(spriteDefence[1],
                    love.graphics.newImage(spriteDefence[2]), spriteDefence[3])
        end
        self.playerDefenceFX:play()
        self.playerDefenceFX:onLoop(function()
            self.playerDefenceFX:stop()
            self.isPlayerDefenceFXDone = true
        end)
    else
        self.isPlayerDefenceFXDone = true
    end

    if isPlayingDefence(currentEnemy) or (currentEnemy.defence>0 and isPlayerAttackSuccess) then
        if self.enemyDefenceFX == nil then
            self.enemyDefenceFX = peachy.new(spriteDefence[1],
                    love.graphics.newImage(spriteDefence[2]), spriteDefence[3])
        end
        self.enemyDefenceFX:play()
        self.enemyDefenceFX:onLoop(function()
            self.enemyDefenceFX:stop()
            self.isEnemyDefenceFXDone = true
        end)
    else
        self.isEnemyDefenceFXDone = true
    end
end

function ResolutionState:playerShiftSpace()
    if player.playingCardAsAction then
        self.isPlayerShiftSpaceDone = true
        return 
    end
    map:shiftSpace(player.targetSlot, player.playingCard, function()
        self.isPlayerShiftSpaceDone = true
    end)
end

function ResolutionState:shiftSpace()
    local enemyShiftSpace = currentEnemy.playingCard.action.onShiftSpace
    if enemyShiftSpace ~= nil then
        enemyShiftSpace(currentEnemy.targetSlot, function()
            self:playerShiftSpace()
        end)
    else
        self:playerShiftSpace()
    end
end

function ResolutionState.cleanCards()
    -- cant use currentCardId, because drop card ability maybe make id wrong
    table.remove(player.hand, table.find(player.hand, player.playingCard))
    player.currentCardId = 0
    if player.playingCardAsAction then
        decks.PlayerDeck:discardCard(player.playingCard)
    end 
    player.playingCard = nil

    if currentEnemy.isPlayingSpecialCard then
        currentEnemy.specialCard:moveTo(specialCardX, specialCardY)
    else
        local enemyDeck = decks[currentEnemy.deck]
        enemyDeck:discardCard(currentEnemy.playingCard)
    end
    currentEnemy.playingCard = nil
end

function ResolutionState:reset()
    player.attack = 0
    player.defence = 0
    currentEnemy.attack = 0
    currentEnemy.defence = 0
    player.damagePending = 0
    currentEnemy.damagePending = 0
    
    self.playerFX = nil
    self.enemyFX = nil
    
    self.playerSFX = nil
    self.enemySFX = nil
    
    self.isCardMoveDone = false
    
    self.isPlayerFXDone = false
    self.isEnemyFXDone = false

    self.isPlayerShiftSpaceDone = false
    
    self.isPlayerMoveDone = false
    self.isEnemyMoveDone = false
    
    self.isPlayerDefenceFXDone = false
    self.isEnemyDefenceFXDone = false
    
    self.isPlayerEffectDone = false
    self.isEnemyEffectDone = false
end