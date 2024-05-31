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
            self.xMax = 62
            self.yMax = 30
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = love.event.quit
        end,

        ["RestartButton"] = function(player)
            self.isVisible = false
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 72
            self.y = 949
            self.xMax = 77
            self.yMax = 30
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = function(player) self:reset(player) end
        end,

        ["OneButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x + 1
            self.y = 955
            self.xMax = 30 + 6
            self.yMax = 30 + 6
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = function(player)self:oneButton(player) end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,

        ["TwoButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x + 1
            self.y = 955
            self.xMax = 30 + 6
            self.yMax = 30 + 6
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = function(player)self:oneButton(player) end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,

        ["ThreeButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x + 1
            self.y = 955
            self.xMax = 30 + 6
            self.yMax = 30 + 6
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = function(player)self:oneButton(player) end
            self.scaleX = 1.25
            self.scaleY = 1.25
        end,

        ["FourButton (1)"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x + 1
            self.y = 955
            self.xMax = 30 + 6
            self.yMax = 30 + 6
            self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)
            self.func = function(player)self:oneButton(player) end
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

    if self.name == "RestartButton" then self.isVisible = player.isDeath end

    self:updateHitBoxes()

end

function Button:draw()

    if self.isVisible then
        --love.graphics.rectangle("fill", self.width[1], self.heigh[1], self.width[2], self.heigh[2])
        love.graphics.draw(self.image, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, self.rotation, self.scaleX * widthCorrectionFactor, self.scaleY * heightCorrectionFactor)
        --love.graphics.rectangle("fill", self.width[1], self.heigh[1], self.width[2], self.heigh[2])

    else
        love.graphics.draw(self.image, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, self.rotation, self.scaleX * widthCorrectionFactor, self.scaleY * heightCorrectionFactor)
        love.graphics.setColor(0, 0, 0, 0.5) -- vermelho com 50% de transparência
        love.graphics.rectangle("fill", self.width[1], self.heigh[1], self.width[2], self.heigh[2])
        love.graphics.setColor(1, 1, 1, 1)
        --love.graphics.rectangle("fill", self.width[1], self.heigh[1], self.width[2], self.heigh[2])

    end
       
end

function Button:reset(player)
    if player.isDeath then
        self:resetPlayer(player)
    end
end

function Button:oneButton(player)
    player:isKeyOnePressed()
end

function Button:setHitBoxes(x, y, xMax, yMax)

    local heigh = {(y) * heightCorrectionFactor, yMax * heightCorrectionFactor}
    local width = {(x) * widthCorrectionFactor, xMax  * widthCorrectionFactor}
    local hitBoxX= {width[1], width[1] + width[2]}
    local hitBoxY = {heigh[1], heigh[1] + heigh[2]}

    return heigh, width, hitBoxX, hitBoxY
end

function Button:updateHitBoxes()
    self.heigh, self.width, self.hitBoxX, self.hitBoxY = self:setHitBoxes(self.x, self.y, self.xMax, self.yMax)

end

function Button:resetPlayer(player)
    player.isDeath = false
    player.animationEnd = false
    player.currentFrame = 1
    player:setIdleImages()
    player.health = 100
    player.energy = 100

end

return Button