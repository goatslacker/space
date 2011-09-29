class Game
  r: null
  WIDTH: 1024
  HEIGHT: 768

  constructor: ->
    @r = Raphael 0, 0, @WIDTH, @HEIGHT

  rnd: ->
    Math.random()

  getX: ->
    @rnd() * @WIDTH

  getY: ->
    @rnd() * @HEIGHT
