local class = require("library/middleclass")

---@class Enemy
local Enemy = class("enemy")

function Enemy:initialize(typeEnemy)
    --Imagens de estado ocioso quando o Enemy estiver olhando para direita
    self.images = {}
    self.enemyName = typeEnemy

    --Carregar as imagens 
    self.loadedImages = self:loadImages(typeEnemy)
    
    --Define o set atual de imagens
    self.images = self:setImages("liveImages")

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
    self:setup(typeEnemy)

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
        self:updateHitBoxes()
    end

    if not self.isExploding then
        self.y = self.y + self.speed * dt
        self:updateHitBoxes()
    end

    --Troca de imagens para explosao
    if self.isExploding then
        if self.explosionTime >= 30 * 0.1 then
            self.explosionTime = self.explosionTime - 5 * 0.1
            self.isExploding = false 
            self.explosionTime = 0
            self.y = -200
            self.x = math.random(0,1600)
            self:updateHitBoxes()
            self.speed = self.speed + self.speedIncrement
            self.images = self:setImages("liveImages")
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
                self.images = self:setImages("explosionImages")
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
                self.images = self:setImages("explosionImages")
                self.explosionTime = self.explosionTime + dt
            end
        end
    end
end

function Enemy:loadImages(typeEnemy)
    local loadedImages = {
        ["liveImages"]      = {},
        ["explosionImages"] = {}
    }

    local function loadImagesIntoTable(imageTable, basePath, count, begin)
        for i = begin, count do
            table.insert(imageTable, love.graphics.newImage(basePath .. i - 1 .. ".png"))
        end
    end

    loadImagesIntoTable(loadedImages["liveImages"],         "assets/enemies/" ..typeEnemy .."/" .. typeEnemy .."000", 10, 1)
    loadImagesIntoTable(loadedImages["liveImages"],         "assets/enemies/" ..typeEnemy .."/" .. typeEnemy .."00", 21, 11)
    loadImagesIntoTable(loadedImages["explosionImages"],    "assets/fx/2/2000", 10, 1)
    loadImagesIntoTable(loadedImages["explosionImages"],      "assets/fx/2/200", 23, 11)

    return loadedImages
end

function Enemy:setImages(setImages)
    if self.loadedImages and self.loadedImages[setImages] then
        return self.loadedImages[setImages]
    else
        print("Erro: Conjunto de imagens '" .. tostring(setImages) .. "' não encontrado.")
        return nil
    end
end

function Enemy:setHitBoxes(x, y, xMax, yMax, radioMax)
    local hitBoxY = (self.y + yMax) * heightCorrectionFactor
    local hitBoxX = (self.x + xMax) * widthCorrectionFactor
    local radio = radioMax  * (widthCorrectionFactor/heightCorrectionFactor)
    
    return hitBoxY, hitBoxX, radio

end

function Enemy:updateHitBoxes()

    if self.enemyName == "01" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "02" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "03" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "04" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "05" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "06" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    elseif self.enemyName == "07" then
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end

end

function Enemy:setup(typeEnemy)
    if typeEnemy == "01" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 65
        self.yMax = 130
        self.radioMax = 30
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)
    end

    if typeEnemy == "02" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 67
        self.yMax = 180
        self.radioMax = 10
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end

    if typeEnemy == "03" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 67
        self.yMax = 180
        self.radioMax = 10
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)
    end

    if typeEnemy == "04" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 63
        self.yMax = 165
        self.radioMax = 25
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end

    if typeEnemy == "05" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 63
        self.yMax = 165
        self.radioMax = 25
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end

    if typeEnemy == "06" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 72
        self.yMax = 165
        self.radioMax = 25
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end

    if typeEnemy == "07" then
        self.y = -200
        math.randomseed(os.time())
        self.x = math.random(35,800) -- limite superior 800 limite inferior 35
        self.xMax = 63
        self.yMax = 65
        self.radioMax = 25
        self.hitBoxY, self.hitBoxX, self.radio = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax, self.radioMax)

    end
end

return Enemy