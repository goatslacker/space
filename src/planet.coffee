class Planet

  constructor: (@x, @y, @size, @color) ->

  draw: ->
    game.r.circle(@x, @y, @size).attr(
      fill: "hsb(#{@color}, .7, .9)"
      stroke: "none"
    )
