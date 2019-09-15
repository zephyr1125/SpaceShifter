function InitAssets()
    -- UI
    imgName = love.graphics.newImage('assets/images/name.png')
    imgBackground = love.graphics.newImage('assets/images/background.png')
    imgTutorial1 = love.graphics.newImage('assets/images/tutorial_1.png')
    imgTutorial2 = love.graphics.newImage('assets/images/tutorial_2.png')
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
    imgDeckBg = love.graphics.newImage('assets/images/deck_bg.png')
    imgDeckCountBg = love.graphics.newImage('assets/images/deck_count_bg.png')
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
    spriteDefence = {'assets/sprites/shield.json','assets/sprites/shield.png', 'effect'}
    --sfx
    imgSFXFireball = love.graphics.newImage('assets/images/sfx/fireball.png')
    imgSFXRoundAttack = love.graphics.newImage('assets/images/sfx/round_attack.png')
    -- sound
    soundFireballStart = love.audio.newSource('assets/sounds/fireball_start.wav', 'static')
    soundFireballHit = love.audio.newSource('assets/sounds/fireball_hit.wav', 'static')
    soundRoundAttack = love.audio.newSource('assets/sounds/round_attack.ogg', 'static')
    soundHit2 = love.audio.newSource('assets/sounds/hit02.ogg', 'static')
    soundPickCard = love.audio.newSource('assets/sounds/pick_card.wav', 'static')
    soundPlayCard = love.audio.newSource('assets/sounds/play_card.wav', 'static')
    musicBGM =  love.audio.newSource('assets/sounds/bgm.mp3', 'stream')
end