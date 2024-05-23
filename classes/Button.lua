local Bar = require("/classes/Bar")

local Button = Bar:subclass("Button")

function Button:initialize(name)
    Bar:initialize(name)
    self.name = name
    self.func = 0

    self.case = {
        ["QuitButton"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 10
            self.y = 949
            self.heigh = 30
            self.width = 62
            self.hitBoxX = {self.x, self.x + self.width}
            self.hitBoxY = {self.y, self.y + self.heigh}
            self.func = love.event.quit
        end,

        ["RestartButton"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 72
            self.y = 950
            self.heigh = 30
            self.width = 77
            self.hitBoxX = {self.x, self. x + self.width}
            self.hitBoxY = {self.y, self.y + self.heigh}
            self.func = love.event.quit
        end,   
    }

    if self.case[name] then
        self.case[name]()
    end   
end

function Button:mousepressed(x, y, button, istouch, presses,player)
    local case = {
        ["QuitButton"] = function()
            print(self.name)
            self.func() -- fechar o jogo
        end,

        ["RestartButton"] = function()
            print(self.name)
            self:reset(player) -- reset o jogo
        end
    }

    if button == 1 then -- botão esquerdo do mouse
        if case[self.name] then
            case[self.name]()
        else
        end

    end
end

function Button:draw()
    --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
    --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2], self.hitBoxY[2])
end

function Button:reset(player)
    if player.isDeath then
        player.isDeath = false
        player.animationEnd = false
        player.currentFrame = 1
        player:setIdleImages()
        player.health = 100
        player.energy = 100
    end
end

return Button