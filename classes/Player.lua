local class = require("library/middleclass")
local Spell = require("classes/Spell")

---@class Player
local Player = class("player")

function Player:initialize()

    self.loadedImages = self:loadImages()

    --conjunto de imagens usadas atualmente
    self.images = self:setImages("idleImagesRight") --conjunto de imagens usadas atualmente
    
    --Posição inicial
        self.x = 500
        self.xMin = 200
        self.xMax = 105
        self.y = 500
        self.yMin = 225
        self.yMax = 200

    --Hit boxes
        self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMin, self.xMax, self.yMin, self.yMax)

    --Velocidade de caminhada
        self.speed = 200

    --Salto
        self.isJumping = false
        self.vy = 0

    --Ataque
        self.isAttacking = false
        self.isBloking = false

    --Saude
        self.health = 100
        self.maxHealth = 100
    --Energia
        self.energy = 100
        self.maxEnergy = 100

    --Personagem abatido
        self.isDeath = false

    --Orientação no eixo X
        self.isLookingRight = true

    --Atributos de animação
        self.currentFrame = 1
        self.timeSinceTheLastChange = 0
        self.frameInterval = 0.1 -- tempo em segundos para trocar de quadro
        self.attackTime = 0 -- Tempo decorrido desde o início do ataque
        self.deathTime = 0
        self.animationEnd = false

    --Speels
        self.spells =self:loadSpells()
        self.isPlayer = true
        self.floor = 500
end

function Player:draw()
    --Desenha o hitbox
    --love.graphics.rectangle("fill", self.width[1], self.heigh[1], self.width[2], self.heigh[2])

    -- Verificar se o índice do array é válido
    local imagem = self.images[math.min(self.currentFrame, #self.images)]
    --local imagem = self.images[self.currentFrame]

    -- Desenhar o quadro atual do personagem
    love.graphics.draw(imagem, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, 0, widthCorrectionFactor, heightCorrectionFactor)

    self:drawSpells()
    
end

function Player:update(dt)
    if not self.isDeath then
        -- Aplicar a gravidade
        self:gravity(dt)

        if self.isBloking and not love.mouse.isDown(2) then
            self.isBloking = false
        end

        -- Verificar se o personagem atingiu a altura máxima do pulo
        self:isMaxHeigh()

        --Salto
        self:jump(dt)

        -- Verificar se o personagem está se movendo e trocar a animação
        self:isMoving(dt)

        --Verifica se o personagem esta atacando
        if self.isAttacking then
            self:setAttackImages(dt)
        end

        self:updateHitBoxes(dt)
        self:updateSpells(self.x, self.y, dt)
        self:animation(dt)
        --self:updateMapParameters()
    else
        self:updateHitBoxes(dt)
        self:deathAnimation(dt)

    end

end

function Player:keypressed(key)
    --Nao vai pular enquanto estiver bloqueando
    if self.isBloking == false then
        if key == "space" and not self.isJumping then
            -- Aplicar a força do pulo
            self.vy = 600
            self.isJumping = true

            if self.isLookingRight then
                self.images = {self:setImages("jumpImagesRight")[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
            else
                self.images = {self:setImages("jumpImagesLeft")[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
            end
        end
    end

    if key == "1" then
        self:isKeyOnePressed()
    end

    if key == "2" then
        self:isKeyTwoPressed()
    end

    if key == "3" then
        self:isKeyThreePressed()
    end

    if key == "4" then
        self:isKeyFourPressed()
    end

end

function Player:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- Executar a animação de ataque
        if not self.isJumping then 
            self.isAttacking = true

            if self.isLookingRight then
                self.images = self:setImages("attackImagesRight")
            else
                self.images = self:setImages("attackImagesLeft")
            end
            self.currentFrame = 1
            self.attackTime = 0 -- Reinicializar o tempo de ataque
        end
    end
end

function Player:gravity(dt)
    self.vy = self.vy - 700 * dt
end

function Player:isMaxHeigh()
    if self.y <= (340) then
        -- Trocar para a segunda imagem do conjunto de imagens de pulo
        if self.isLookingRight then
            self.images = { self:setImages("jumpImagesRight")[2] }
        else
            self.images = { self:setImages("jumpImagesLeft")[2] }
        end
    end
end

function Player:jump(dt)
    if self.isJumping then
        self.y = self.y - self.vy * dt
        if self.y >= self.floor then
            self.y = self.floor
            self.vy = 0
            self.isJumping = false
        end
    end
end

function Player:isKeyDPressed(dt)
    self.isLookingRight = true
    self.x = self.x + self.speed * dt
    if not self.isJumping then self.images = self:setImages("runImagesRight") end
    
end

function Player:isKeyAPressed(dt)
    self.isLookingRight = false
    self.x = self.x - self.speed * dt
    if not self.isJumping then self.images = self:setImages("runImagesLeft") end
end

function Player:isKeyOnePressed()
    self:useSpell(self.spells[1])

end

function Player:isKeyTwoPressed()
    print("Botao 2")
end

function Player:isKeyThreePressed()
    print("Botao 3")
end

function Player:isKeyFourPressed()
    print("Botao 4")
end

function Player:isMouseButton2Pressed(button)
    --Não vai conseguir defender enquanto estiver no ar
    if self.isJumping == false then
        self.isBloking = true
        if self.isLookingRight then
            self.images = {self:setImages("attackImagesRight")[3]}
        else
            self.images = {self:setImages("attackImagesLeft")[3]}
        end
    end
end

function Player:isMoving(dt)
    --Se estiver defendendo, não irá conseguir andar
    if self.isBloking == false then
        if love.keyboard.isDown("a") then
            self:isKeyAPressed(dt)
        elseif love.keyboard.isDown("d") then
            self:isKeyDPressed(dt)
        elseif love.mouse.isDown(2) then
            self:isMouseButton2Pressed(button)
        else
            self:setIdleImages()
        end
    end
end

function Player:setIdleImages()
    if self.isLookingRight then
        if not self.isAttacking and not self.isJumping then
            self.images = self:setImages("idleImagesRight")
        end
    else
        if not self.isAttacking and not self.isJumping then
            self.images = self:setImages("idleImagesLeft")
        end
    end
end

function Player:setAttackImages(dt)
    -- Atualizar o temporizador de animação de ataque
    self.attackTime = self.attackTime + dt

    if self.attackTime >= 10 * self.frameInterval then
        -- Ajustar o tempo de ataque para evitar que exceda o limite de 10 frames por imagem
    self.attackTime = self.attackTime - 10 * self.frameInterval
        -- Trocar para a próxima imagem de ataque
        self.currentFrame =self.currentFrame % #self.images + 1

    end
    if self.currentFrame == 4 then
        self.isAttacking = false
        self:setIdleImages()
    end
end

function Player:animation(dt)
    self.timeSinceTheLastChange = self.timeSinceTheLastChange + dt
    if self.timeSinceTheLastChange >= self.frameInterval then
        self.timeSinceTheLastChange = 0
        self.currentFrame = self.currentFrame % #self.images + 1
    end
end

function Player:deathAnimation(dt)
    if not self.animationEnd then
        self.images = self:setImages("deathImages")
        self.animationEnd= true
    end

    self.y = 500

    --self:animation(dt)
    -- Atualizar o temporizador de animação de ataque
    self.deathTime = self.deathTime + dt

    if self.deathTime >= 10 * self.frameInterval then
        -- Ajustar o tempo de ataque para evitar que exceda o limite de 10 frames por imagem
    self.deathTime = self.deathTime - 10 * self.frameInterval
        -- Trocar para a próxima imagem de ataque
        self.currentFrame =self.currentFrame % #self.images + 1

    end
    if self.currentFrame == 3 and self.animationEnd then
        self.images = {self:setImages("deathImages")[3]}
    end
end

function Player:loadImages()
    local loadedImages = {
        ["idleImagesRight"] =   {},
        ["idleImagesLeft"] =    {},
        ["jumpImagesRight"] =   {},
        ["jumpImagesLeft"] =    {},
        ["runImagesRight"] =    {},
        ["runImagesLeft"] =     {},
        ["attackImagesRight"] = {},
        ["attackImagesLeft"] =  {},
        ["deathImages"] =       {}
    }

    local function loadImagesIntoTable(imageTable, basePath, count)
        for i = 1, count do
            table.insert(imageTable, love.graphics.newImage(basePath .. i .. ".png"))
        end
    end

    loadImagesIntoTable(loadedImages["idleImagesRight"],   "/assets/character/12/", 4)
    loadImagesIntoTable(loadedImages["idleImagesLeft"],    "/assets/character/11/", 4)
    loadImagesIntoTable(loadedImages["jumpImagesRight"],   "/assets/character/22/", 2)
    loadImagesIntoTable(loadedImages["jumpImagesLeft"],    "/assets/character/21/", 2)
    loadImagesIntoTable(loadedImages["runImagesRight"],    "/assets/character/32/", 4)
    loadImagesIntoTable(loadedImages["runImagesLeft"],     "/assets/character/31/", 4)
    loadImagesIntoTable(loadedImages["attackImagesRight"], "/assets/character/42/", 4)
    loadImagesIntoTable(loadedImages["attackImagesLeft"],  "/assets/character/41/", 4)
    loadImagesIntoTable(loadedImages["deathImages"],       "/assets/character/5/", 3)

    return loadedImages
end

function Player:setImages(setImages)
    if self.loadedImages and self.loadedImages[setImages] then
        return self.loadedImages[setImages]
    else
        print("Erro: Conjunto de imagens '" .. tostring(setImages) .. "' não encontrado.")
        return nil
    end
end

function Player:loadSpells()
    local spell = {}
    spell[1] = Spell:new("mana_shield",self.x,self.y)

    return spell
end

function Player:updateSpells(x, y, dt)
    for i = 1, #self.spells do
        self.spells[i]:update(self.x, self.y, dt)
    end

end

function Player:drawSpells()
    for i = 1, #self.spells do
        self.spells[i]:draw()
    end
end

function Player:useSpell(spell)
    if self.energy >= spell.mana and not spell.useSpell and not spell.isInCD then
        spell:use()
        self.energy = self.energy - spell.mana
    end

end

function Player:setHitBoxes(x, y, xMin, xMax, yMin, yMax)

    local width = {(x + xMin) * widthCorrectionFactor, xMax  * widthCorrectionFactor}
    local heigh = {(y + yMin) * heightCorrectionFactor, yMax * heightCorrectionFactor}
    local hitBoxX = {width[1], width[1] + width[2]}
    local hitBoxY = {heigh[1], heigh[1] + heigh[2]}

    return heigh, width, hitBoxX, hitBoxY
end

function Player:updateHitBoxes()
    self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMin, self.xMax, self.yMin, self.yMax)

end

return Player