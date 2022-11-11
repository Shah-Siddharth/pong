require("components.Ball")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    ball = Ball:init(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)
end

function love.update(dt)
    
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
end