local Bar = require("/classes/Bar")

local Button = Bar:subclass("Button")

function Button:initialize(name)
    Bar:initialize(name)
    self.func = 0

    self.case = {
        ["QuitText"] = function()
            self.image = love.graphics.newImage("assets/gui/".. name ..".png")
            self.x = -15
            self.y = 910
            self.heigh = 45
            self.width = 125
            self.hitBoxX = {self.x + 17, self.x + 140}
            self.hitBoxY = {self.y + 23,self.y + 23 + 45}
            self.func = love.event.quit
        end,   
    }

    if self.case[name] then
        self.case[name]()
    end   
end

function Button:mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- botão esquerdo do mouse
        if x >= self.hitBoxX[1] and x <= self.hitBoxX[2] and
            y >= self.hitBoxY[1] and y <= self.hitBoxY[2] then
            self.func() -- fechar o jogo
        end
    end
end
return Button