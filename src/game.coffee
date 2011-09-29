class Game
  raph: null
  WIDTH: 1024
  HEIGHT: 768

  constructor: ->
    @raph = Raphael 0, 0, @WIDTH, @HEIGHT

  rnd: ->
    Math.random()

  getX: ->
    @rnd() * @WIDTH

  getY: ->
    @rnd() * @HEIGHT


Game.animate = (render, element) ->
  lastFrame = +new Date
  running = undefined

  animation = (now) ->
    if running != false
      requestAnimationFrame animation, element
      running = render(now - lastFrame)
      lastFrame = now

  animation lastFrame
