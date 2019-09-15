function InitAssets()
    -- UI
    imgBackground = love.graphics.newImage('assets/images/background.png')
    imgSlotSelect = love.graphics.newImage('assets/images/slot_select.png')
    imgRewardSelect = love.graphics.newImage('assets/images/reward_select.png')
    imgDiscardSelect = love.graphics.newImage('assets/images/discard_select.png')
    imgTipCursor = love.graphics.newImage('assets/images/tip_cursor.png')
    imgButtonY = love.graphics.newImage('assets/images/button_y.png')
    imgDamageTip = love.graphics.newImage('assets/images/damage_tip.png')
    imgHealTip = love.graphics.newImage('assets/images/heal_tip.png')
    imgCardActionBg = love.graphics.newImage('assets/images/card_action.png')
    imgCardSpaceBg = love.graphics.newImage('assets/images/card_space.png')
    imgPlayerFrame = love.graphics.newImage('assets/images/player_frame.png')
    imgEnemyFrame = love.graphics.newImage('assets/images/enemy_frame.png')
    imgConnectionEnemyFrame = love.graphics.newImage('assets/images/connection_enemy_frame.png')
    imgSpecialCard = love.graphics.newImage('assets/images/special_card.png')
    -- characters
    imgPlayerSprite = love.graphics.newImage('assets/images/sprite/player.png')
    imgBansheeSprite = love.graphics.newImage('assets/images/sprite/banshee.png')
    imgGhostSprite = love.graphics.newImage('assets/images/sprite/ghost.png')
    imgTrollSprite = love.graphics.newImage('assets/images/sprite/troll.png')
    imgPlayerPortrait = love.graphics.newImage('assets/images/portrait/player.png')
    imgBansheePortrait = love.graphics.newImage('assets/images/portrait/banshee.png')
    imgGhostPortrait = love.graphics.newImage('assets/images/portrait/ghost.png')
    imgTrollPortrait = love.graphics.newImage('assets/images/portrait/troll.png')
    -- sprite
    spritePlayer = peachy.new("assets/sprites/oldHero.json",
            love.graphics.newImage("assets/sprites/oldHero.png"), 'run')
    spriteDefence = {'assets/sprites/shield.json','assets/sprites/shield.png', 'effect'}
    -- sound
    soundHit1 = love.audio.newSource("assets/sounds/hit01.wav", "static")
    soundHit2 = love.audio.newSource('assets/sounds/hit02.ogg', 'static')
end