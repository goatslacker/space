class Star

  constructor: (@x = 0, @y = 0) ->

  draw: ->
    game.raph.circle(@x, @y, 1).attr(
      fill: "hsb(1, .1, 1)"
      stroke: "none"
    )
