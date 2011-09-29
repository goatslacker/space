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
