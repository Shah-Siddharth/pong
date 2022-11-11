Ball = {}
Ball.__index = Ball

function Ball:init(x, y, width, height)
    local newBall = {}
    setmetatable(newBall, Ball)
    
    newBall.x = x
    newBall.y = y
    newBall.width = width
    newBall.height = height
    newBall.dx = math.random(-50, 50)
    newBall.dy = math.random(2) == 1 and -100 or 100
    
    return newBall
end

function Ball:reset()
    self.x = WINDOW_WIDTH/2 - self.width/2
    self.y = WINDOW_HEIGHT/2 - self.height/2
    self.dx = math.random(-50, 50)
    self.dy = math.random(2) == 1 and -100 or 100
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end