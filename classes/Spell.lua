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
end                      

function Spell:draw()                        
    if self.useSpell then
        --love.graphics.rectangle("fill", self.hitBoxes[1][1], self.hitBoxes[2][1], self.radio * 2 * widthCorrectionFactor, self.radio * 2 * heightCorrectionFactor)
        --love.graphics.circle("fill", 285 + self.x - 90, 285 +  self.y - 90, self.radio)
        love.graphics.draw(self.image, self.x * widthCorrectionFactor, self.y * heightCorrectionFactor, 0, 0.7 * widthCorrectionFactor, 0.7 * heightCorrectionFactor) --width[1] - 90, heigh[1] - 50,0,1,1)
    end
end

function Spell:update(x,y)
    self.x = x + 60
    self.y = y + 130
    self.hitBoxes = {{ (self.x + 15) * widthCorrectionFactor, (self.x + 2 * self.radio) * widthCorrectionFactor}, {(self.y + 15) * heightCorrectionFactor, (self.y + self.radio * 2) * heightCorrectionFactor}}


end

function Spell:use()
    self.useSpell = not self.useSpell
end

return Spell
