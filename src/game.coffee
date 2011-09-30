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

  rect_collision: (box, x, y) ->
    true if x > box.x and x < (box.x + box.width) and y > box.y and y < (box.y + box.height)
    false

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
