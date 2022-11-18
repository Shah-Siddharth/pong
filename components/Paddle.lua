Paddle = {}
Paddle.__index = Paddle

function Paddle:init(x, y, width, height)
    local newPaddle = {}
    setmetatable(newPaddle, self)

    newPaddle.x = x
    newPaddle.y = y
    newPaddle.width = width
    newPaddle.height = height
    newPaddle.dy = 0

    return newPaddle
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(WINDOW_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end