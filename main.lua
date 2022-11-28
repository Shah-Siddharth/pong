require("components.Ball")
require("components.Paddle")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

BALL_WIDTH = 10

PADDLE_SPEED = 200
PADDLE_WIDTH = 10

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    math.randomseed(os.time())

    scoreFont = love.graphics.newFont(25)


    ball = Ball:init(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)
    player1 = Paddle:init(10, 30, 10, 50)
    player2 = Paddle:init(WINDOW_WIDTH-10-10, 30, 10, 50)

    player1Score = 0
    player2Score = 0
    
    gameState = 'start'
end

function love.update(dt)

    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.25
            ball.x = player1.x + PADDLE_WIDTH
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.25
            ball.x = player2.x - BALL_WIDTH
        end
    end

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
    
    if gameState == 'play' then
        ball:update(dt)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ball:reset()
        end
    end
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), 100, WINDOW_HEIGHT/3)
    love.graphics.print(tostring(player2Score), WINDOW_WIDTH-100, WINDOW_HEIGHT/3)
end

function love.draw()
    love.graphics.printf(
        "Pong!",
        0,
        WINDOW_HEIGHT/2 - 6,
        WINDOW_WIDTH,
        "center"
    )

    displayScore()

    ball:render()
    player1:render()
    player2:render()
end
