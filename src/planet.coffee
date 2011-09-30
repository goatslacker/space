class Planet

  constructor: (@x, @y, @radius, @color) ->
    @radius or= Planet.MIN_RADIUS
    @color or= 0.5

  draw: ->
    @value = game.raph.circle(@x, @y, @radius).attr(
      fill: "hsb(#{@color}, 0.7, 0.9)"
      stroke: "none"
    )

  metrics: ->
    @value.getBBox()

Planet.getRadius = ->
  Math.ceil(Math.random() * (Planet.MAX_RADIUS - Planet.MIN_RADIUS)) + Planet.MIN_RADIUS

Planet.MAX_RADIUS = 70
Planet.MIN_RADIUS = 40
