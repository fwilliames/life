function love.load()
    --Requires
    Player = require("classes/Player")
    Enemy = require("classes/Enemy")
    Gui = require("classes/Gui")

    -- Carregar o mapa
    mapa = love.graphics.newImage("/assets/background/Desert Night_bg.png")

    --Configurar Janela
    success = love.window.setFullscreen(true, "desktop")

    --Fatores de correção de escala
    local width, height = love.graphics.getDimensions()
    widthCorrectionFactor = width/mapa:getWidth()
    heightCorrectionFactor = height/mapa:getHeight()

    --Carregar GUI
    myGui = Gui:new()

    --Carregar Player
    myPlayer = Player:new()

    --Carregar Enemies
    myEnemies = {}
    local i = 1
    local numberOfEnemies = 7
    while i <= numberOfEnemies do
        myEnemies[i] = Enemy:new("0" .. i)
        i = i + 1
    end

end

function love.update(dt)
    --Player Update
    myPlayer:update(dt)

    --GUI update
    myGui:update(dt, myPlayer)
   
    --Enemies Updates
    local i = 1
    while i <= #myEnemies do
        myEnemies[i]:update(dt)
        myEnemies[i]:checkCollision(myPlayer,dt)
        myEnemies[i]:checkCollision(myPlayer.spells[1],dt)
        i = i + 1
    end

    --Atualizar Fatores de escala
    width, height = love.graphics.getDimensions()
    widthCorrectionFactor = width/mapa:getWidth()
    heightCorrectionFactor = height/mapa:getHeight()
    
end

function love.keypressed(key)
    myPlayer:keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    myGui:mousepressed(x, y, button, istouch, presses, myPlayer)
    myPlayer:mousepressed(x, y, button, istouch, presses)

end

function love.draw()
    -- Desenhar o mapa
    love.graphics.draw(mapa, 0, 0, 0, widthCorrectionFactor, heightCorrectionFactor)

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
  