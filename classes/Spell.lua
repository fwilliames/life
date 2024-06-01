local class = require("library/middleclass")

---@class Spell
local Spell = class("spell")

function Spell:initialize(name,x,y)
    self.image = love.graphics.newImage("assets/fx/6/".. name ..".png")
    self.x =  x + 60
    self.y = y + 130
    self.radio = 180 --180
    self.useSpell = false
    self.hitBoxes = {{ (self.x + 15) * widthCorrectionFactor, (self.x + 2 * self.radio) * widthCorrectionFactor}, {(self.y + 15) * heightCorrectionFactor, (self.y + self.radio * 2) * heightCorrectionFactor}}
    self.isPlayer = false
    self.mana = 10
    self.spellDuration = 5
    self.countDown = 20
    self.isInCD = false

end                      

function Spell:draw()                        
    if self.useSpell then
        --love.graphics.rectangle("fill", self.hitBoxes[1][1], self.hitBoxes[2][1], self.radio * 2 * widthCorrectionFactor, self.radio * 2 * heightCorrectionFactor)
        --love.graphics.circle("fill", 285 + self.x - 90, 285 +  self.y - 90, self.radio)
        love.graphics.draw(self.image, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, 0, 0.7 * widthCorrectionFactor, 0.7 * heightCorrectionFactor) --width[1] - 90, heigh[1] - 50,0,1,1)
    end
end

function Spell:update(x, y, dt)
    self.x = x + 60
    self.y = y + 130
    self.hitBoxes = {{ (self.x + 15) * widthCorrectionFactor, (self.x + 2 * self.radio) * widthCorrectionFactor}, {(self.y + 15) * heightCorrectionFactor, (self.y + self.radio * 2) * heightCorrectionFactor}}

    if self.useSpell and self.spellDuration >= 0 then self.spellDuration = self.spellDuration - dt end
    if self.countDown >= 0 and self.isInCD then self.countDown = self.countDown - dt end

    if self.spellDuration < 0 then
        self.useSpell = false
        self.spellDuration = 5
        self.isInCD = true
    end

    if self.countDown < 0 then
        self.isInCD = false
        self.countDown = 20
    end

end

function Spell:use()
    if not self.isInCD then
        self.useSpell = not self.useSpell
        self.isInCD = true
    end
end

return Spell
