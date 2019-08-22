local class = require('lib.hump.class')
local sti = require('lib.sti')

local TileTestScreen = class {}

function TileTestScreen:init(ScreenManager)
    self.screen = ScreenManager
    
    map = sti("assets/maps/desert.lua")

    -- Create new dynamic data layer called "Sprites" as the 8th layer
    local layer = map:addCustomLayer("Sprites")

    -- Get player spawn object
    local player
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            player = object
            break
        end
    end

    -- Create player object
    local sprite = love.graphics.newImage("assets/images/player.png")
    layer.player = {
        sprite = sprite,
        x = player.x,
        y = player.y,
        ox = sprite:getWidth() / 8,
        oy = sprite:getHeight() / 4
    }

    -- Add controls to player
    layer.update = function(self, dt)
        -- 96 pixels per second
        local speed = 96

        -- Move player up
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            self.player.y = self.player.y - speed * dt
        end

        -- Move player down
        if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
            self.player.y = self.player.y + speed * dt
        end

        -- Move player left
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            self.player.x = self.player.x - speed * dt
        end

        -- Move player right
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            self.player.x = self.player.x + speed * dt
        end
    end


    -- Draw player
    layer.draw = function(self)
        img = self.player.sprite
        quad = love.graphics.newQuad(0, 0, 16, 32, img:getDimensions())
        love.graphics.draw(
                img,
                quad,
                math.floor(self.player.x),
                math.floor(self.player.y),
                0,
                1,
                1,
                self.player.ox,
                self.player.oy
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        --love.graphics.setPointSize(5)
        --love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn Point")
end

function TileTestScreen:activate()
    
end

function TileTestScreen:update(dt)
    map:update(dt)
end

function TileTestScreen:draw()
    love.graphics.print("Tile Test", 10, 10)
    map:draw()
end

function TileTestScreen:keyreleased(key)
    if key == keys.X then
        self.screen:view('/')
    end
end

return TileTestScreen