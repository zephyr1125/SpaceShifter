return {
    Mountain = {
        name = 'Mountain',
        icon = 'mountain',
        effectIcon = 'defence1',
        spaceAnim = 'mountain',
        score = 1,
        onCountDefence = function()
            return 1
        end
    },
    Plain = {
        name = 'Plain',
        icon = 'plain',
        effectIcon = 'attack1',
        spaceAnim = 'plain',
        score = 1,
        onCountAttack = function()
            return 1
        end
    }
    
}