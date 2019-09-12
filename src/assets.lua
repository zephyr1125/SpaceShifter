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
    spritePlayer = peachy.new("assets/sprites/oldHero.json",
            love.graphics.newImage("assets/sprites/oldHero.png"), 'run')
    soundHit1 = love.audio.newSource("assets/sounds/hit01.wav", "static")
end