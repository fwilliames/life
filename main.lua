function love.load()
    -- Carregar o mapa
    mapa = love.graphics.newImage("/assets/background/Desert Night_bg.png")
    
    love.window.setMode(mapa:getWidth(), mapa:getHeight())

    Player = require("classes/Player")
    myPlayer = Player:new()

end

function love.update(dt)
    myPlayer:update(dt)

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

end
  