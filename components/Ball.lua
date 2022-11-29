Ball = {}
Ball.__index = Ball

function Ball:init(x, y, width, height)
    local newBall = {}
    setmetatable(newBall, Ball)
    
    newBall.x = x
    newBall.y = y
    newBall.width = width
    newBall.height = height
    newBall.dx = math.random(2) == 1 and -50 or 50
    newBall.dy = math.random(2) == 1 and -100 or 100
    
    return newBall
end

function Ball:reset()
    self.x = WINDOW_WIDTH/2 - self.width/2
    self.y = WINDOW_HEIGHT/2 - self.height/2
    self.dx =  math.random(2) == 1 and -50 or 50
    self.dy = math.random(2) == 1 and -100 or 100
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
    end
    
    if self.y >= WINDOW_HEIGHT - self.height then
        self.y = WINDOW_HEIGHT - self.height
        self.dy = -self.dy
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
