function love.load()
    -- Carregar o mapa
    mapa = love.graphics.newImage("/assets/background/Desert Night_bg.png")
    
    love.window.setMode(mapa:getWidth(), mapa:getHeight())

    Player = require("classes/Player")
    myPlayer = Player:new()

    Enemy = require("classes/Enemy")
    --Fireball = 07
    --DarkFlame = 06
    myEnemies = {Enemy:new("01"),Enemy:new("02"),Enemy:new("03"),Enemy:new("04"),Enemy:new("05"),Enemy:new("06"),Enemy:new("07")}

    --myEnemy = Enemy:new("fireball")

end

function love.update(dt)
    myPlayer:update(dt)
    myEnemies[1]:update(dt)
    myEnemies[1]:checkCollision(myPlayer,dt)

    myEnemies[2]:update(dt)
    myEnemies[2]:checkCollision(myPlayer,dt)

    myEnemies[3]:update(dt)
    myEnemies[3]:checkCollision(myPlayer,dt)

    myEnemies[4]:update(dt)
    myEnemies[4]:checkCollision(myPlayer,dt)

    myEnemies[5]:update(dt)
    myEnemies[5]:checkCollision(myPlayer,dt)

    myEnemies[6]:update(dt)
    myEnemies[6]:checkCollision(myPlayer,dt)

    myEnemies[7]:update(dt)
    myEnemies[7]:checkCollision(myPlayer,dt)
    
end

function love.keypressed(key)
    myPlayer:keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    myPlayer:mousepressed(x, y, button, istouch, presses)

end

function love.draw()
    -- Desenhar o mapa
    love.graphics.draw(mapa, 0, 0, 0)

    -- Desenhar o player
    myPlayer:draw()

    myEnemies[1]:draw()
    
    myEnemies[2]:draw()
    myEnemies[3]:draw()
    myEnemies[4]:draw()
    myEnemies[5]:draw()
    myEnemies[6]:draw()
    myEnemies[7]:draw()
    
end
  