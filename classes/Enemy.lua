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
    if typeEnemy == "01" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.x + 130 ) * heightCorrectionFactor
        self.hitBoxX = (self.y + 65) * widthCorrectionFactor
        self.radio = 30  * (widthCorrectionFactor/heightCorrectionFactor)
    end

    if typeEnemy == "02" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    if typeEnemy == "03" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    if typeEnemy == "04" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    if typeEnemy == "05" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    if typeEnemy == "06" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    if typeEnemy == "06" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.hitBoxY = (self.y + 180) * heightCorrectionFactor
        self.hitBoxX = (self.x + 67) * widthCorrectionFactor
        self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

    end

    --Atributos de Explosao
    self.explosionTime = 0
    self.isExploding = false

end

function Enemy:draw()
   -- Verificar se o índice do array é válido
   local imagem = self.images[math.min(self.currentFrame, #self.images)]

    love.graphics.draw(
        imagem,
        self.x * widthCorrectionFactor,
        self.y * heightCorrectionFactor,
        self.rotation * widthCorrectionFactor * heightCorrectionFactor,
        widthCorrectionFactor,
        heightCorrectionFactor
    )
    --love.graphics.circle("fill", self.hitBoxX, self.hitBoxY, self.radio)
end

function Enemy:update(dt)

    if self.y >= 1000 then
        self.y = -200
        self.x = math.random(0,1600)
        self.speed = self.speed + self.speedIncrement
        
        if self.enemyName == "01" then
            self.hitBoxY = (self.y + 130 ) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 30  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "02" then
            self.hitBoxY = (self.y + 180) * heightCorrectionFactor
            self.hitBoxX = (self.x + 67) * widthCorrectionFactor
            self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "03" then
            self.hitBoxY = (self.y + 180) * heightCorrectionFactor
            self.hitBoxX = (self.x + 67) * widthCorrectionFactor
            self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "04" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 63) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "05" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 63) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "06" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "07" then
            self.hitBoxY = (self.y + 65) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 19  * (widthCorrectionFactor/heightCorrectionFactor)
        end
    end

    if not self.isExploding then
        self.y = self.y + self.speed * dt

        if self.enemyName == "01" then
            self.hitBoxY = (self.y + 130 ) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 30  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "02" then
            self.hitBoxY = (self.y + 180) * heightCorrectionFactor
            self.hitBoxX = (self.x + 67) * widthCorrectionFactor
            self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "03" then
            self.hitBoxY = (self.y + 180) * heightCorrectionFactor
            self.hitBoxX = (self.x + 67) * widthCorrectionFactor
            self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "04" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 63) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "05" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 63) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "06" then
            self.hitBoxY = (self.y + 170) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

        elseif self.enemyName == "07" then
            self.hitBoxY = (self.y + 65) * heightCorrectionFactor
            self.hitBoxX = (self.x + 65) * widthCorrectionFactor
            self.radio = 19  * (widthCorrectionFactor/heightCorrectionFactor)
        end
    end

    --Troca de imagens para explosao
    if self.isExploding then
        if self.explosionTime >= 30 * 0.1 then
            self.explosionTime = self.explosionTime - 5 * 0.1
            self.isExploding = false 
            self.explosionTime = 0
            self.y = -200
            self.x = math.random(0,1600)

            if self.enemyName == "01" then
                self.hitBoxY = (self.y + 130 ) * heightCorrectionFactor
                self.hitBoxX = (self.x + 65) * widthCorrectionFactor
                self.radio = 30  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "02" then
                self.hitBoxY = (self.y + 180) * heightCorrectionFactor
                self.hitBoxX = (self.x + 67) * widthCorrectionFactor
                self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "03" then
                self.hitBoxY = (self.y + 180) * heightCorrectionFactor
                self.hitBoxX = (self.x + 67) * widthCorrectionFactor
                self.radio = 10  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "04" then
                self.hitBoxY = (self.y + 170) * heightCorrectionFactor
                self.hitBoxX = (self.x + 63) * widthCorrectionFactor
                self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "05" then
                self.hitBoxY = (self.y + 170) * heightCorrectionFactor
                self.hitBoxX = (self.x + 63) * widthCorrectionFactor
                self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "06" then
                self.hitBoxY = (self.y + 170) * heightCorrectionFactor
                self.hitBoxX = (self.x + 65) * widthCorrectionFactor
                self.radio = 20  * (widthCorrectionFactor/heightCorrectionFactor)

            elseif self.enemyName == "07" then
                self.hitBoxY = (self.y + 65) * heightCorrectionFactor
                self.hitBoxX = (self.x + 65) * widthCorrectionFactor
                self.radio = 19  * (widthCorrectionFactor/heightCorrectionFactor)
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

    local obj_left = 0
    local obj_right = 0
    local obj_top = 0
    local obj_bottom = 0

    if obj.isPlayer then
        obj_left = obj.hitBoxX[1]
        obj_right = obj.hitBoxX[2]
        obj_top = obj.hitBoxY[1]
        obj_bottom = obj.hitBoxY[2]
    else
        obj_left = obj.hitBoxes[1][1]
        obj_right = obj.hitBoxes[1][2]
        obj_top = obj.hitBoxes[2][1]
        obj_bottom = obj.hitBoxes[2][2]
        obj_radio = obj.radio
    end

    if obj.isPlayer then
        if  self_right > obj_left
        and self_left < obj_right
        and self_bottom > obj_top
        and self_top < obj_bottom then

            if not self.isExploding then
                self.isExploding = true
                self.images = self.explosionImages
                self.explosionTime = self.explosionTime + dt

                if obj.health > 0 then
                    if not obj.isBloking or obj.energy <= 0 then
                        obj.health = obj.health - 10
                    else
                        obj.energy = obj.energy - 30
                    end
                else
                    obj.isDeath = true
                end
            end
        end
    else
        if self_right > obj_left
        and self_left < obj_right
        and self_bottom > obj_top
        and self_top < obj_bottom then

            if not self.isExploding and obj.useSpell then
                self.isExploding = true
                self.images = self.explosionImages
                self.explosionTime = self.explosionTime + dt
            end
        end
    end
end

return Enemy