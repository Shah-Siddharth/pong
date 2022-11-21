require("components.Ball")
require("components.Paddle")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_SPEED = 200

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    ball = Ball:init(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)
    
    player1 = Paddle:init(10, 30, 10, 50)
    player2 = Paddle:init(WINDOW_WIDTH-10-10, 30, 10, 50)
end

function love.update(dt)

    -- player1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end
    
    -- player2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

end

function love.draw()
    love.graphics.printf(
        "Pong!",
        0,
        WINDOW_HEIGHT/2 - 6,
        WINDOW_WIDTH,
        "center"
    )

    ball:render()
    player1:render()
    player2:render()
end