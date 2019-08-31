return {
    {
        name = '山脉',
        icon = 'mountain',
        effectIcon = 'defence1',
        spaceAnim = 'mountain',
        score = 1,
        onCountDefence = function()
            return 1
        end
    },
    {
        name = '平原',
        icon = 'plain',
        effectIcon = 'attack1',
        spaceAnim = 'plain',
        score = 1,
        onCalcAttack = function()
            return 1
        end
    },
    {
        name = '墓地',
        icon = 'graveyard',
        effectIcon = 'harm1',
        spaceAnim = 'graveyard',
        score = 2,
        onRoundStart = function(resident)
            resident.life = resident.life -1
        end
    }
    
}