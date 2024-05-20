local class = require("library/middleclass")

---@class Player
local Player = class("player")

function Player:initialize()
    --Imagens de estado ocioso quando o player estiver olhando para direita
    self.idleImagesRight = {
        love.graphics.newImage("/assets/character/character_idle_0_r.png"),
        love.graphics.newImage("/assets/character/character_idle_1_r.png"),
        love.graphics.newImage("/assets/character/character_idle_2_r.png"),
        love.graphics.newImage("/assets/character/character_idle_3_r.png")
    }
    --Imagens de estado ocioso quando o player estiver olhando para esquerda
    self.idleImagesLeft = {
        love.graphics.newImage("/assets/character/character_idle_0_l.png"),
        love.graphics.newImage("/assets/character/character_idle_1_l.png"),
        love.graphics.newImage("/assets/character/character_idle_2_l.png"),
        love.graphics.newImage("/assets/character/character_idle_3_l.png")
    }
    --Imagens de salto quando o player estiver olhando para direita
    self.jumpImagesRight = {
        love.graphics.newImage("/assets/character/character_jump_0_r.png"),
        love.graphics.newImage("/assets/character/character_jump_1_r.png")
    }
    --Imagens de salto quando o player estiver olhando para esquerda
    self.jumpImagesLeft = {
        love.graphics.newImage("/assets/character/character_jump_0_l.png"),
        love.graphics.newImage("/assets/character/character_jump_1_l.png")
    }
    --Imagens de caminhada quando o player estiver olhando para direita
    self.runImagesRight = {
        love.graphics.newImage("/assets/character/character_run_0_r.png"),
        love.graphics.newImage("/assets/character/character_run_1_r.png"),
        love.graphics.newImage("/assets/character/character_run_2_r.png"),
        love.graphics.newImage("/assets/character/character_run_3_r.png")

    }
    --Imagens de caminhada quando o player estiver olhando para esquerda
    self.runImagesLeft = {
        love.graphics.newImage("/assets/character/character_run_0_l.png"),
        love.graphics.newImage("/assets/character/character_run_1_l.png"),
        love.graphics.newImage("/assets/character/character_run_2_l.png"),
        love.graphics.newImage("/assets/character/character_run_3_l.png")

    }
    --Imagens de ataque quando o player estiver olhando para direita
    self.attackImagesRight = {
        love.graphics.newImage("/assets/character/character_sword_Attack_0_r.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_1_r.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_2_r.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_3_r.png"),
    }
    --Imagens de ataque quando o player estiver olhando para esquerda
    self.attackImagesLeft = {
        love.graphics.newImage("/assets/character/character_sword_Attack_0_l.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_1_l.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_2_l.png"),
        love.graphics.newImage("/assets/character/character_sword_Attack_3_l.png"),
    }

    self.images = self.idleImagesRight --conjunto de imagens usadas atualmente
    self.x = -185
    self.y = 500
    self.vy = 0
    self.isJumping = false 
    self.isAttacking = false
    self.isLookingRight = true
    self.speed = 200
    self.currentFrame = 1
    self.timeSinceTheLastChange = 0
    self.frameInterval = 0.1 -- tempo em segundos para trocar de quadro
    self.attackTime = 0 -- Tempo decorrido desde o início do ataque
    
end

function Player:draw()
    -- Verificar se o índice do array é válido
    local imagem = self.images[math.min(self.currentFrame, #self.images)]

    -- Desenhar o quadro atual do personagem
    love.graphics.rectangle("fill", self.x + 200, self.y + 225, 105, 200)
    love.graphics.draw(imagem, self.x, self.y)
    
end

function Player:update(dt)
     -- Aplicar a gravidade
    self.vy = self.vy - 700 * dt

     -- Verificar se o personagem atingiu a altura máxima do pulo
    if self.y <= 340 then
        -- Trocar para a segunda imagem do conjunto de imagens de pulo
        if self.isLookingRight then
            self.images = { self.jumpImagesRight[2] }
        else
            self.images = { self.jumpImagesLeft[2] }
        end
    end
 
    -- Aplicar o pulo
    if self.isJumping then
        self.y = self.y - self.vy * dt
        if self.y >= 500 then
            self.y = 500
            self.vy = 0
            self.isJumping = false
        end
    end
 
    -- Atualizar o temporizador e trocar de quadro se necessário
    self.timeSinceTheLastChange = self.timeSinceTheLastChange + dt
    if self.timeSinceTheLastChange >= self.frameInterval then
        self.timeSinceTheLastChange = 0
        self.currentFrame = self.currentFrame % #self.images + 1
    end
 
     -- Verificar se o personagem está se movendo e trocar a animação
    if love.keyboard.isDown("a") then
        self.isLookingRight = false
        self.x = self.x - self.speed * dt
    if not self.isJumping then self.images = self.runImagesLeft end

    elseif love.keyboard.isDown("d") then
       self.isLookingRight = true
        self.x = self.x + self.speed * dt
        if not self.isJumping then self.images = self.runImagesRight end
    else
        if self.isLookingRight then 
            if not self.isAttacking and not self.isJumping then
                self.images = self.idleImagesRight
            end
        else
            if not self.isAttacking and not self.isJumping then
                self.images = self.idleImagesLeft
            end
        end
    end
 
    if self.isAttacking then
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
            if self.isLookingRight then
                self.images = self.idleImagesRight -- Voltar para as imagens de idle após o ataque
            else
                self.images = self.idleImagesLeft -- Voltar para as imagens de idle após o ataque
            end
        end
    end
end

function Player:keypressed(key)
    if key == "space" and not self.isJumping then
        -- Aplicar a força do pulo
        self.vy = 500
        self.isJumping = true

        if self.isLookingRight then
           self.images = {self.jumpImagesRight[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
        else
            self.images = {self.jumpImagesLeft[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
        end
    end
end

function Player:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- Executar a animação de ataque
        if not self.isJumping then 
            self.isAttacking = true

            if self.isLookingRight then
                self.images = self.attackImagesRight
            else
                self.images = self.attackImagesLeft
            end
            self.currentFrame = 1
            self.attackTime = 0 -- Reinicializar o tempo de ataque
        end
    end
end

return Player