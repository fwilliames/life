local Bar = require("/classes/Bar")

local Button = Bar:subclass("Button")

function Button:initialize(name,x)
    Bar:initialize(name)
    self.name = name
    self.func = 0
    self.isVisible = true

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

        ["RestartButton"] = function(player)
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 72
            self.y = 950
            self.heigh = 30
            self.width = 77
            self.hitBoxX = {self.x, self. x + self.width}
            self.hitBoxY = {self.y, self.y + self.heigh}
            self.func = function(player) self:reset(player) end
        end,

        ["OneButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x
            self.y = 955
            self.heigh = 30
            self.width = 30
            self.hitBoxX = {self.x+1, self. x + self.width + 6}
            self.hitBoxY = {self.y+1, self.y + self.heigh + 6}
            self.func = function(player)self:oneButton(player) end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,
        ["TwoButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x
            self.y = 955
            self.heigh = 30
            self.width = 30
            self.hitBoxX = {self.x+1, self. x + self.width + 6}
            self.hitBoxY = {self.y+1, self.y + self.heigh + 6}
            self.func = function() print("botao 2") end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,
        ["ThreeButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x
            self.y = 955
            self.heigh = 30
            self.width = 30
            self.hitBoxX = {self.x+1, self. x + self.width + 6}
            self.hitBoxY = {self.y+1, self.y + self.heigh + 6}
            self.func = function() print("botao 3") end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,
        ["FourButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x
            self.y = 955
            self.heigh = 30
            self.width = 30
            self.hitBoxX = {self.x+1, self. x + self.width + 6}
            self.hitBoxY = {self.y+1, self.y + self.heigh + 6}
            self.func = function() print("botao 4") end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,
    }

    if self.case[name] then
        self.case[name]()
    end   
end

function Button:mousepressed(x, y, button, istouch, presses,player)
    self.func(player)
end

function Button:update(player)
    self.isVisible = player.isDeath
end

function Button:draw()

    local case = {
        ["QuitButton"] = function()
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
            love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
        end,

        ["RestartButton"] = function()

            if self.isVisible then
                love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
            else
                love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
                love.graphics.setColor(0, 0, 0, 0.5) -- vermelho com 50% de transparência
                love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end,

        ["OneButton (1)"] = function()
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
            love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
        end,
        ["TwoButton (1)"] = function()
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
            love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
        end,
        ["ThreeButton (1)"] = function()
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
            love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
        end,
        ["FourButton (1)"] = function()
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
            love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
            --love.graphics.rectangle("fill", self.hitBoxX[1], self.hitBoxY[1], self.hitBoxX[2] - self.x, self.hitBoxY[2] - self.y)
        end,

    }
        if case[self.name] then
            case[self.name]()
        else

    end

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

function Button:oneButton(player)
    player:isKeyOnePressed()
end

return Button