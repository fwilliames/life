function love.load()
    --Requires
    Player = require("classes/Player")
    Enemy = require("classes/Enemy")
    Gui = require("classes/Gui")

    -- Carregar o mapa
    mapa = love.graphics.newImage("/assets/background/Desert Night_bg.png")
   
    --Configurar Janela
    love.window.setMode(mapa:getWidth(), mapa:getHeight(), {resizable=true})

    --Carregar GUI
    myGui = Gui:new()
   
    --Carregar Player
    myPlayer = Player:new()

    --Carregar Enemies
    myEnemies = {}
    local i = 1
    local numberOfEnemies = 0
    while i <= numberOfEnemies do
        myEnemies[i] = Enemy:new("0" .. i)
        i = i + 1
    end
 
end

function love.update(dt)
    --Player Update
    myPlayer:update(dt)
   
    --Enemies Updates
    local i = 1
    while i <= #myEnemies do
        myEnemies[i]:update(dt)
        myEnemies[i]:checkCollision(myPlayer,dt)
        i = i + 1
    end
    
end

function love.keypressed(key)
    myPlayer:keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    myGui:mousepressed(x, y, button, istouch, presses)
    myPlayer:mousepressed(x, y, button, istouch, presses)

end

function love.draw()
    -- Desenhar o mapa
    love.graphics.draw(mapa, 0, 0, 0)

    --Desenhar GUI
    myGui:draw()

    -- Desenhar o player
    myPlayer:draw()

    -- Desenhar Enemies
    local i = 1

    while i <= #myEnemies do
        myEnemies[i]:draw()
        i = i+ 1
    end
    
end
  