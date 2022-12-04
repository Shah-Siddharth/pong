require("components.Ball")
require("components.Paddle")

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 576

BALL_WIDTH = 10

PADDLE_SPEED = 350
PADDLE_WIDTH = 10

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    math.randomseed(os.time())

    largeFont = love.graphics.newFont('fonts/AtlantisInternational.ttf', 60)
    smallFont = love.graphics.newFont('fonts/AtlantisInternational.ttf', 25)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static')
    }

    ball = Ball:init(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)
    player1 = Paddle:init(10, 30, 10, 50)
    player2 = Paddle:init(WINDOW_WIDTH-10-10, 30, 10, 50)

    player1Score = 0
    player2Score = 0
    
    gameState = 'start'
end

function love.update(dt)

    if gameState == 'play' then

        -- collision with paddles
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.25
            ball.x = player1.x + PADDLE_WIDTH
            
            sounds['paddle_hit']:play()
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.25
            ball.x = player2.x - BALL_WIDTH

            sounds['paddle_hit']:play()
        end

        -- player 2 scores
        if ball.x < 0 then
            player2Score = player2Score + 1

            sounds['score']:play()

            if player2Score == 10 then
                gameState = 'end'
                winningPlayer = 2
            else
                gameState = 'serve'
                servingPlayer = 1
                ball:reset()
                ball.dx = math.abs(ball.dx)
            end
        end

        -- player 1 scores
        if ball.x > WINDOW_WIDTH then
            player1Score = player1Score + 1

            sounds['score']:play()
            
            if player1Score == 10 then
                gameState = 'end'
                winningPlayer = 1
            else
                gameState = 'serve'
                servingPlayer = 2
                ball:reset()
                ball.dx = -math.abs(ball.dx)
            end
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
        elseif gameState == 'end' then
            gameState = 'start'
            ball:reset()
            player1Score = 0
            player2Score = 0
        elseif gameState == 'serve' then
            gameState = 'play'
        end
    end
end

function displayScore()
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(player1Score), WINDOW_WIDTH/2 - 100, WINDOW_HEIGHT/2 - 50)
    love.graphics.print(tostring(player2Score), WINDOW_WIDTH/2 + 100 - largeFont:getWidth(tostring(player2Score)), WINDOW_HEIGHT/2 - 50)
end

function love.draw()
    love.graphics.clear(40/255, 45/255, 52/255, 1)
    
    if gameState == 'serve' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve",
            0,
            25,
            WINDOW_WIDTH,
            'center'
        )
        
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to serve', 
            0, 
            25 + largeFont:getHeight() + 10,
            WINDOW_WIDTH,
            'center'
        )
    
    elseif gameState == 'end' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
            0,
            25,
            WINDOW_WIDTH,
            'center'
        )

        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart',
            0,
            25 + largeFont:getHeight() + 10,
            WINDOW_WIDTH, 'center'
        )

    elseif gameState == 'start' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Welcome to Pong!',
            0,
            25,
            WINDOW_WIDTH,
            'center'
        )

        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to start',
            0,
            25 + largeFont:getHeight() + 10,
            WINDOW_WIDTH,
            'center'
        )
    end
    displayScore()

    ball:render()
    player1:render()
    player2:render()
end
