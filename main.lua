function love.load()
    -- Carregar o mapa
    mapa = love.graphics.newImage("/assets/Desert Night_bg.png")
    
    love.window.setMode(mapa:getWidth(), mapa:getHeight())
    
    -- Definir a posição inicial do personagem
    personagem = {
        idleImagesRight = {
            love.graphics.newImage("/assets/character_idle_0_r.png"),
            love.graphics.newImage("/assets/character_idle_1_r.png"),
            love.graphics.newImage("/assets/character_idle_2_r.png"),
            love.graphics.newImage("/assets/character_idle_3_r.png")
        },
        idleImagesLeft = {
            love.graphics.newImage("/assets/character_idle_0_l.png"),
            love.graphics.newImage("/assets/character_idle_1_l.png"),
            love.graphics.newImage("/assets/character_idle_2_l.png"),
            love.graphics.newImage("/assets/character_idle_3_l.png")
        },
        jumpImagesRight = {
            love.graphics.newImage("/assets/character_jump_0_r.png"),
            love.graphics.newImage("/assets/character_jump_1_r.png")
        },
        jumpImagesLeft = {
            love.graphics.newImage("/assets/character_jump_0_l.png"),
            love.graphics.newImage("/assets/character_jump_1_l.png")
        },
        runImagesRight = {
            love.graphics.newImage("/assets/character_run_0_r.png"),
            love.graphics.newImage("/assets/character_run_1_r.png"),
            love.graphics.newImage("/assets/character_run_2_r.png"),
            love.graphics.newImage("/assets/character_run_3_r.png")

        },
        runImagesLeft = {
            love.graphics.newImage("/assets/character_run_0_l.png"),
            love.graphics.newImage("/assets/character_run_1_l.png"),
            love.graphics.newImage("/assets/character_run_2_l.png"),
            love.graphics.newImage("/assets/character_run_3_l.png")

        },
        attackImagesRight = {
            love.graphics.newImage("/assets/character_sword_Attack_0_r.png"),
            love.graphics.newImage("/assets/character_sword_Attack_1_r.png"),
            love.graphics.newImage("/assets/character_sword_Attack_2_r.png"),
            love.graphics.newImage("/assets/character_sword_Attack_3_r.png"),
        },
        attackImagesLeft = {
            love.graphics.newImage("/assets/character_sword_Attack_0_l.png"),
            love.graphics.newImage("/assets/character_sword_Attack_1_l.png"),
            love.graphics.newImage("/assets/character_sword_Attack_2_l.png"),
            love.graphics.newImage("/assets/character_sword_Attack_3_l.png"),
        },
        images = {},
        x = 100,
        y = 500,
        vy = 0,
        pulando = false, 
        atacando = false,
        lookingRight = true,
        velocidade = 200,
        quadroAtual = 1,
        tempoDesdeUltimaMudanca = 0,
        intervaloDeQuadro = 0.1, -- tempo em segundos para trocar de quadro
        tempoDeAtaque = 0 -- Tempo decorrido desde o início do ataque
    }

    -- Definir imagens iniciais
    personagem.images = personagem.idleImagesRight
end

function love.update(dt)
    -- Aplicar a gravidade
    personagem.vy = personagem.vy - 700 * dt

    -- Verificar se o personagem atingiu a altura máxima do pulo
    if personagem.y <= 340 then
        -- Trocar para a segunda imagem do conjunto de imagens de pulo
        if personagem.lookingRight then
            personagem.images = { personagem.jumpImagesRight[2] }
        else
            personagem.images = { personagem.jumpImagesLeft[2] }
        end
    end

     -- Aplicar o pulo
    if personagem.pulando then
        personagem.y = personagem.y - personagem.vy * dt
        if personagem.y >= 500 then
            personagem.y = 500
            personagem.vy = 0
            personagem.pulando = false
        end
    end

    -- Atualizar o temporizador e trocar de quadro se necessário
    personagem.tempoDesdeUltimaMudanca = personagem.tempoDesdeUltimaMudanca + dt
    if personagem.tempoDesdeUltimaMudanca >= personagem.intervaloDeQuadro then
        personagem.tempoDesdeUltimaMudanca = 0
        personagem.quadroAtual = personagem.quadroAtual % #personagem.images + 1
    end

    -- Verificar se o personagem está se movendo e trocar a animação
    if love.keyboard.isDown("a") then
        personagem.lookingRight = false
        personagem.x = personagem.x - personagem.velocidade * dt
       if not personagem.pulando then personagem.images = personagem.runImagesLeft end


    elseif love.keyboard.isDown("d") then
        personagem.lookingRight = true
        personagem.x = personagem.x + personagem.velocidade * dt
        if not personagem.pulando then personagem.images = personagem.runImagesRight end


    else
        if personagem.lookingRight then 
            if not personagem.atacando and not personagem.pulando then
                personagem.images = personagem.idleImagesRight
            end
        else
            if not personagem.atacando and not personagem.pulando then
                personagem.images = personagem.idleImagesLeft
            end
        end
    end

    if personagem.atacando then
        -- Atualizar o temporizador de animação de ataque
        personagem.tempoDeAtaque = personagem.tempoDeAtaque + dt

        if personagem.tempoDeAtaque >= 10 * personagem.intervaloDeQuadro then
            -- Ajustar o tempo de ataque para evitar que exceda o limite de 10 frames por imagem
            personagem.tempoDeAtaque = personagem.tempoDeAtaque - 10 * personagem.intervaloDeQuadro
            
            -- Trocar para a próxima imagem de ataque
            personagem.quadroAtual = personagem.quadroAtual % #personagem.images + 1
            
        end
        if personagem.quadroAtual == 4 then
            personagem.atacando = false
            if personagem.lookingRight then
                personagem.images = personagem.idleImagesRight -- Voltar para as imagens de idle após o ataque
            else
                personagem.images = personagem.idleImagesLeft -- Voltar para as imagens de idle após o ataque
            end
        end
    end

  
end

function love.keypressed(key)
    if key == "space" and not personagem.pulando then
        -- Aplicar a força do pulo
        personagem.vy = 500
        personagem.pulando = true

        if personagem.lookingRight then
            personagem.images = {personagem.jumpImagesRight[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
        else
            personagem.images = {personagem.jumpImagesLeft[1]} -- Trocar para as imagens de pulo quando o personagem começar a pular
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- Executar a animação de ataque
        personagem.atacando = true

        if personagem.lookingRight then
            personagem.images = personagem.attackImagesRight
        else
            personagem.images = personagem.attackImagesLeft
        end
        personagem.quadroAtual = 1
        personagem.tempoDeAtaque = 0 -- Reinicializar o tempo de ataque
    end
end

function love.draw()
    -- Desenhar o mapa
    love.graphics.draw(mapa, 0, 0, 0)

     -- Verificar se o índice do array é válido
     local imagem = personagem.images[math.min(personagem.quadroAtual, #personagem.images)]

     -- Desenhar o quadro atual do personagem
     love.graphics.draw(imagem, personagem.x, personagem.y)

end
  