class Planet

  constructor: (@x, @y, @size, @color) ->

  draw: ->
    game.raph.circle(@x, @y, @size).attr(
      fill: "hsb(#{@color}, .7, .9)"
      stroke: "none"
    )

Planet.MAX_SIZE = 50
Planet.MIN_SIZE = 30
