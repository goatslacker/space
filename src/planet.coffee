class Planet

  constructor: (@x, @y, @radius, @color) ->

  draw: ->
    @value = game.raph.circle(@x, @y, @radius).attr(
      fill: "hsb(#{@color}, .7, .9)"
      stroke: "none"
    )

  hwxy: ->
    @value.getBBox()

Planet.MAX_RADIUS = 50
Planet.MIN_RADIUS = 30
