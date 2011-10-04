class Star

  constructor: (@x = 0, @y = 0) ->

  draw: ->
    game.raph.circle(@x, @y, 0.53).attr(
      fill: "white"
      stroke: "none"
    )
