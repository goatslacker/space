class Star

  constructor: (@x, @y) ->

  draw: ->
    game.r.circle(@x, @y, 1).attr(
      fill: "hsb(1, .1, 1)"
      stroke: "none"
    )
