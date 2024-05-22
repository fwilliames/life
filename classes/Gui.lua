local class = require("library/middleclass")
local Button = require("classes/Button")

---@class Gui
local Gui = class("gui")

function Gui:initialize()
    
    self.quitButton =       Button:new("QuitText")
    self.holderBar =        Button:new("HealthEnergyHolder")
    self.healthBarHurt =    Button:new("HealthBarHurt2")
    self.healthBarHealthy = Button:new("HealthBarHealthy1")
    self.energyEmpty =      Button:new("EnergyEmpty2")
    self.energyFull =       Button:new("EnergyFull1")

end

function Gui:draw()

    self.quitButton:draw()
    self.holderBar:draw()
    self.healthBarHurt:draw()
    self.healthBarHealthy:draw()
    self.energyEmpty:draw()
    self.energyFull:draw()
    
end

function Gui:update(dt, health, maxHealth, energy, maxEnergy)
    self.healthBarHealthy.scaleX = (health / maxHealth) * 0.37
    self.energyFull.scaleX = (energy / maxEnergy) * 0.37

end

function Gui:mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- botão esquerdo do mouse
        if x >= self.quitButton.hitBoxX[1] and x <= self.quitButton.hitBoxX[2] and
            y >= self.quitButton.hitBoxY[1] and y <= self.quitButton.hitBoxY[2] then
            love.event.quit() -- fechar o jogo
        end
    end
end

return Gui