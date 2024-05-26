local class = require("library/middleclass")
local Bar = require("classes/Bar")
local Button = require("classes/Button")

---@class Gui
local Gui = class("gui")

function Gui:initialize()
    
    self.quitButton =       Button:new("QuitButton")
    self.resetButton =      Button:new("RestartButton")
    self.holderBar =        Bar:new("HealthEnergyHolder")
    self.healthBarHurt =    Bar:new("HealthBarHurt2")
    self.healthBarHealthy = Bar:new("HealthBarHealthy1")
    self.energyEmpty =      Bar:new("EnergyEmpty2")
    self.energyFull =       Bar:new("EnergyFull1")

    self.buttonCaseOne =    Bar:new("ButtonCase", 500)
    self.buttonCaseTwo =    Bar:new("ButtonCase",550)
    self.buttonCaseThree =  Bar:new("ButtonCase",600)
    self.buttonCaseFour =   Bar:new("ButtonCase",650)

    self.oneButton =        Button:new("OneButton (1)",505)
    self.twoButton =        Button:new("TwoButton (1)",555)
    self.threeButton =      Button:new("ThreeButton (1)",605)
    self.fourButton =       Button:new("FourButton (1)",655)

end

function Gui:draw()

    self.quitButton:draw()
    self.resetButton:draw()
    self.holderBar:draw()
    self.healthBarHurt:draw()
    self.healthBarHealthy:draw()
    self.energyEmpty:draw()
    self.energyFull:draw()

    self.buttonCaseOne:draw()
    self.buttonCaseTwo:draw()
    self.buttonCaseThree:draw()
    self.buttonCaseFour:draw()

    self.oneButton:draw()
    self.twoButton:draw()
    self.threeButton:draw()
    self.fourButton:draw()

end

function Gui:update(dt, player)
    self.resetButton:update(player)
    self.quitButton:update(player)
    self.oneButton:update(player)
    self.twoButton:update(player)
    self.threeButton:update(player)
    self.fourButton:update(player)
    self.healthBarHealthy.scaleX = self:updateHealthBar(player)
    self.energyFull.scaleX = self:updateEnergyBar(player)

end

function Gui:mousepressed(x, y, button, istouch, presses, player)
    if x >= self.quitButton.hitBoxX[1] and x <= self.quitButton.hitBoxX[2] and y >= self.quitButton.hitBoxY[1] and y <= self.quitButton.hitBoxY[2] then
        self.quitButton:mousepressed(x, y, button, istouch, presses)

    elseif x >= self.resetButton.hitBoxX[1] and x <= self.resetButton.hitBoxX[2] and y >=self.resetButton.hitBoxY[1] and y <= self.resetButton.hitBoxY[2] then
        self.resetButton:mousepressed(x, y, button, istouch, presses,player)

    elseif x >= self.oneButton.hitBoxX[1] and x <= self.oneButton.hitBoxX[2] and y >=self.oneButton.hitBoxY[1] and y <= self.oneButton.hitBoxY[2] then
        self.oneButton:mousepressed(x, y, button, istouch, presses,player)

    elseif x >= self.twoButton.hitBoxX[1] and x <= self.twoButton.hitBoxX[2] and y >=self.twoButton.hitBoxY[1] and y <= self.twoButton.hitBoxY[2] then
        self.twoButton:mousepressed(x, y, button, istouch, presses,player)

    elseif x >= self.threeButton.hitBoxX[1] and x <= self.threeButton.hitBoxX[2] and y >=self.threeButton.hitBoxY[1] and y <= self.threeButton.hitBoxY[2] then
        self.threeButton:mousepressed(x, y, button, istouch, presses,player)

    elseif x >= self.fourButton.hitBoxX[1] and x <= self.fourButton.hitBoxX[2] and y >=self.fourButton.hitBoxY[1] and y <= self.fourButton.hitBoxY[2] then
        self.fourButton:mousepressed(x, y, button, istouch, presses,player)
    end

end

function Gui:updateHealthBar(player)
    return (player.health / player.maxHealth) * 0.37
end

function Gui:updateEnergyBar(player)
    local tempEnergy = (player.energy / player.maxEnergy) * 0.37

    if tempEnergy >= 0 then
        return (player.energy / player.maxEnergy) * 0.37
    else
        return 0
    end
end

return Gui