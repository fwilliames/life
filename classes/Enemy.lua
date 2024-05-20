local class = require("library/middleclass")

---@class Enemy
local Enemy = class("enemy")

function Enemy:initialize(typeEnemy)
    --Imagens de estado ocioso quando o Enemy estiver olhando para direita
    self.images = {}
    self.enemyName = typeEnemy
    local i = 1
    local j = 30

    self.liveImages = {}
    self.explosionImages = {}

    --Carregar as imagens 
    while i< j do
        if i > 10 then
            self.liveImages[i] =  love.graphics.newImage("/assets/enemies/".. typeEnemy .."/".. typeEnemy .."00".. (i - 1) .. ".png")
        else
            self.liveImages[i] =  love.graphics.newImage("/assets/enemies/".. typeEnemy .."/".. typeEnemy.."000".. (i - 1) .. ".png")
        end
        i = i + 1
    end

    --Carregar imagens da explosao
    i = 1
    j = 32
    while i< j do
        if i > 10 then
            self.explosionImages[i] =  love.graphics.newImage("/assets/fx/2/200" ..(i - 1) .. ".png")
        else
            self.explosionImages[i] =  love.graphics.newImage("/assets/fx/2/2000" ..(i - 1) .. ".png")
        end
        i = i + 1
    end

    --Define o set atual de imagens
    self.images = self.liveImages

    self.x = 0
    self.y = 0
    self.speed = 100
    self.speedIncrement = 10
    
    --Atributos de animação
    self.currentFrame = 1
    self.timeSinceTheLastChange = 0
    self.frameInterval = 0.1 -- tempo em segundos para trocar de quadro
    self.rotation = 0
    
    --Hitbox
    self.hitBoxY = 0
    self.hitBoxX = 0
    self.radio = 0
    
    --Definicao de atributos de acordo com tipo de inimigo criado
    self.case = {
        ["01"] = function()
            if self.y == 0 or self.x == 0 then
                self.y = -200
                math.randomseed(os.time())
                self.x = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 130
            self.hitBoxX = self.x + 65
            self.radio = 30
           
        end,
        ["02"] = function()
            if self.y == 0 or self.x == 0 then
                self.x = 1600
                math.randomseed(os.time())
                self.y = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 73
            self.hitBoxX = self.x - 185
            self.radio = 10
            self.rotation = 300
        end,
        ["03"] = function()
            if self.y == 0 or self.x == 0 then
                self.x = 1600
                math.randomseed(os.time())
                self.y = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 73
            self.hitBoxX = self.x - 165
            self.radio = 30
            self.rotation = 300
        end,
        ["04"] = function()
            if self.y == 0 or self.x == 0 then
                self.y = -200
                math.randomseed(os.time())
                self.x = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 155
            self.hitBoxX = self.x + 65
            self.radio = 30
        end,
        ["05"] = function()
            if self.y == 0 or self.x == 0 then
                self.y = -200
                math.randomseed(os.time())
                self.x = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 155
            self.hitBoxX = self.x + 65
            self.radio = 30
        end,
        ["06"] = function()
            if self.y == 0 or self.x == 0 then
                self.x = 1600
                math.randomseed(os.time())
                self.y = math.random(35,800) -- limite superior 800 limite inferior 35
            end

            self.hitBoxY = self.y + 75
            self.hitBoxX = self.x - 165
            self.radio = 30
            self.rotation = 300
        end,
        ["07"] = function()
            if self.y == 0 or self.x == 0 then
                self.x = 1600
                math.randomseed(os.time())
                self.y = math.random(35,800) -- limite superior 800 limite inferior 35
            end
            self.hitBoxY = self.y + 65
            self.hitBoxX = self.x + 65
            self.radio = 35
        end
    }
    if self.case[self.enemyName] then
        self.case[self.enemyName]()
    else 
        print("No enemies was chosen")
    end

    --Atributos de Explosao
    self.explosionTime = 0
    self.isExploding = false

end

function Enemy:draw()
   -- Verificar se o índice do array é válido
   local imagem = self.images[math.min(self.currentFrame, #self.images)]

    if self.case[self.enemyName] then
        self.case[self.enemyName]()
    else 
        print("No enemies was chosen")
    end

    --Desenha do hitbox
    --love.graphics.circle("fill", self.hitBoxX, self.hitBoxY, self.radio)

    -- Desenhar o quadro atual
    if self.enemyName == "06" or self.enemyName == "02" or self.enemyName == "03" then
        love.graphics.draw(imagem, self.x, self.y, self.rotation, -1, -1)
    else
        love.graphics.draw(imagem, self.x, self.y, self.rotation)
    end

end

function Enemy:update(dt)
    if self.enemyName == "01" or self.enemyName == "04" or self.enemyName == "05" then
        if self.y >= 1000 then
            self.y = -200
            self.x = math.random(0,1600)
            self.speed = self.speed + self.speedIncrement
         
        end
        if not self.isExploding then self.y = self.y + self.speed * dt end
    else
        if self.x <= -200 then
        self.y = math.random(35,800)
        self.x = 1800
        self.speed = self.speed + self.speedIncrement
        
        end

        if not self.isExploding then self.x = self.x - self.speed * dt end
    end

    --Troca de imagens para explosao
    if self.isExploding then
        if self.explosionTime >= 30 * 0.1 then
            self.explosionTime = self.explosionTime - 5 * 0.1
            self.isExploding = false 
            self.explosionTime = 0

            if self.enemyName == "01" or self.enemyName == "04" or self.enemyName == "05" then
                self.y = -200
                self.x = math.random(0,1600)
            else
                self.y = math.random(35,800)
                self.x = 1800
            end

            self.speed = self.speed + self.speedIncrement
            self.images = self.liveImages
            self.isExploding = false 
               
        end
        self.explosionTime = self.explosionTime + dt
     
    end
    -- Atualizar o temporizador e trocar de quadro se necessário
    self.timeSinceTheLastChange = self.timeSinceTheLastChange + dt
    if self.timeSinceTheLastChange >= self.frameInterval then
        self.timeSinceTheLastChange = 0
        self.currentFrame = self.currentFrame % #self.images + 1
    end
 
end

function Enemy:checkCollision(obj,dt)

    local self_left = self.hitBoxX - self.radio
    local self_right = self.hitBoxX + self.radio
    local self_top = self.hitBoxY - self.radio
    local self_bottom = self.hitBoxY + self.radio

    local obj_left = obj.hitBoxX[1]
    local obj_right = obj.hitBoxX[2]
    local obj_top = obj.hitBoxY[1]
    local obj_bottom = obj.hitBoxY[2]

    if  self_right > obj_left
    and self_left < obj_right
    and self_bottom > obj_top
    and self_top < obj_bottom then
        if not self.isExploding then
            self.isExploding = true
            self.images = self.explosionImages
            self.explosionTime = self.explosionTime + dt
        end
    end
end

return Enemy