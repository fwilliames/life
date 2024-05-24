local class = require("library/middleclass")

---@class Spell
local Spell = class("spell")

function Spell:initialize(name,x,y)
    self.image = love.graphics.newImage("assets/fx/6/".. name ..".png")
    self.x =  x + 60
    self.y = y + 130
    self.radio = 180 --180
    self.useSpell = false
    self.hitBoxes = {{ self.x + 15, self.x + 2 * self.radio}, {self.y + 15, self.y + self.radio*2}}
    self.isPlayer = false
    self.mana = 10
end                      

function Spell:draw()                        
    if self.useSpell then
        --love.graphics.rectangle("fill", self.x + 15, self.y + 15, self.radio * 2, self.radio*2)
        --love.graphics.circle("fill", 285 + self.x - 90, 285 +  self.y - 90, self.radio)
        love.graphics.draw(self.image, self.x, self.y, 0, 0.7, 0.7) --width[1] - 90, heigh[1] - 50,0,1,1)
    end
end

function Spell:update(x,y)
    self.x = x + 60
    self.y = y + 130
    self.hitBoxes = {{ self.x + 15, self.x + 2 * self.radio}, {self.y + 15, self.y + self.radio*2}}

end

function Spell:use()
    self.useSpell = not self.useSpell
end

return Spell
