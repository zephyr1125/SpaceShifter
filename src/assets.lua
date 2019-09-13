function InitAssets()
    imgPreview = love.graphics.newImage('assets/images/preview.png')
    imgMapSlot = love.graphics.newImage("assets/images/map_slot.png")
    imgSlotSelect = love.graphics.newImage('assets/images/slot_select.png')
    imgRewardSelect = love.graphics.newImage('assets/images/reward_select.png')
    imgDiscardSelect = love.graphics.newImage('assets/images/discard_select.png')
    imgBansheeSprite = love.graphics.newImage('assets/images/banshee.png')
    imgGreedSprite = love.graphics.newImage('assets/images/greed.png')
    imgTipCursor = love.graphics.newImage('assets/images/tip_cursor.png')
    imgButtonY = love.graphics.newImage('assets/images/button_y.png')
    imgDamageTip = love.graphics.newImage('assets/images/damage_tip.png')
    imgHealTip = love.graphics.newImage('assets/images/heal_tip.png')
    -- sprite
    spritePlayer = peachy.new("assets/sprites/oldHero.json",
            love.graphics.newImage("assets/sprites/oldHero.png"), 'run')
    spriteDefence = {'assets/sprites/shield.json','assets/sprites/shield.png', 'effect'}
    -- sound
    soundHit1 = love.audio.newSource("assets/sounds/hit01.wav", "static")
end