local class = require("library/middleclass")

---@class Bar
local Bar = class("button")

function Bar:initialize(name, x)

    self.image = 0
    self.x = 0
    self.y = 0
    self.heigh = 0
    self.width = 0
    self.hitBoxX = {0, 0}
    self.hitBoxY = {0, 0}
    self.rotation = 0
    self.scaleX = 1
    self.scaleY = 1

    self.case = {

        ["HealthEnergyHolder"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 0
            self.y = 10
            self.heigh = 45
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23, self.y + 23 + 45}
            self.scaleX = 0.35
            self.scaleY = 0.2
        end,
        
        ["HealthBarHurt2"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 64
            self.y = 17
            self.heigh = 45
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            self.scaleX = 0.37
            self.scaleY = 0.28
        end,
        
        ["HealthBarHealthy1"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 64
            self.y = 17
            self.heigh = 45
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            self.scaleX = 0.37
            self.scaleY = 0.28
        end,
        
        ["EnergyEmpty2"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 72
            self.y = 52
            self.heigh = 48
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            self.scaleX = 0.37
            self.scaleY = 0.28
        end,
        
        ["EnergyFull1"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = 72
            self.y = 52
            self.heigh = 48
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            self.scaleX = 0.37
            self.scaleY = 0.28
        end,
        
        ["ButtonCase"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = x
            self.y = 950
            self.heigh = 48
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            --self.scaleX = 0.37
            --self.scaleY = 0.28
        end
    }

    if self.case[name] then
        self.case[name]()
    end
end

function Bar:draw()
    love.graphics.draw(self.image, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, self.rotation, self.scaleX * widthCorrectionFactor, self.scaleY * heightCorrectionFactor)
end

return Bar