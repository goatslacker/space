class Star

  constructor: (@x, @y) ->

  draw: ->
    game.raph.circle(@x, @y, 1).attr(
      fill: "hsb(1, .1, 1)"
      stroke: "none"
    )
