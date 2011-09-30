class Game
  raph: null

  constructor: ->
    @raph = Raphael 0, 0, Game.WIDTH, Game.HEIGHT

  rnd: ->
    Math.random()

  getX: ->
    @rnd() * Game.WIDTH

  getY: ->
    @rnd() * Game.HEIGHT

  getColor: ->
    (Math.floor(Math.random() * 10) + 1) / 10

  time_to_collision: (c1, c2) ->
    t = 0

    A = (c1.vx * c1.vx) + (c1.vy * c1.vy) - 2 * c1.vx * c2.vx + (c2.vx * c2.vx) - 2 * c1.vy * c2.vy + (c2.vy * c2.vy)
    B = -c1.x * c1.vx - c1.y * c1.vy + c1.vx * c2.x + c1.vy * c2.y + c1.x * c2.vx - c2.x * c2.vx + c1.y * c2.vy - c2.y * c2.vy
    C = (c1.vx * c1.vx) + (c1.vy * c1.vy) - 2 * c1.vx * c2.vx + (c2.vx * c2.vx) - 2 * c1.vy * c2.vy + (c2.vy * c2.vy)
    D = (c1.x * c1.x) + (c1.y * c1.y) - (c1.r * c1.r) - 2 * c1.x * c2.x + (c2.x * c2.x) - 2 * c1.y * c2.y + (c2.y * c2.y) - 2 * c1.r * c2.r - (c2.r * c2.r)
    disc = ((-2 * B) * (-2 * B)) - 4 * C * D

    if disc >= 0
      t = Math.min(Math.min(t, 0.5 * (2 * B - Math.sqrt(disc)) / A), 0.5 * (2 * B + Math.sqrt(disc)) / A)

    t

  circle_collision: (c1, c2) ->
    dx = c1.x - c2.x
    dy = c1.y - c2.y

    dist = c1.radius + c2.radius

    (dx * dx) + (dy * dy) <= (dist * dist)

  rect_collision: (box, x, y) ->
    return true if x > box.x and x < (box.x + box.width) and y > box.y and y < (box.y + box.height)
    return false

# TODO: animations should be performed server-side. Client-side we just update the positions
Game.animate = (render, element) ->
  lastFrame = +new Date
  running = undefined

  animation = (now) ->
    if running != false
      requestAnimationFrame animation, element

      # if delta (now - lastFrame) is less than 160 then we render the next frame
      running = render(now - lastFrame) if (now - lastFrame) < 160
      lastFrame = now

  animation lastFrame

Game.WIDTH = 1024
Game.HEIGHT = 768
Game.PLANETS = 5
Game.STARS = 1000
