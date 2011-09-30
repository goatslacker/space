class Planet

  constructor: (@x, @y, @radius, @color) ->

  draw: ->
    @value = game.raph.circle(@x, @y, @radius).attr(
      fill: "hsb(#{@color}, .7, .9)"
      stroke: "none"
    )

  metrics: ->
    o = @value.getBBox()
    o.radius = @radius
    o

Planet.getRadius = ->
  Math.ceil(Math.random() * (Planet.MAX_RADIUS - Planet.MIN_RADIUS)) + Planet.MIN_RADIUS

Planet.MAX_RADIUS = 70
Planet.MIN_RADIUS = 40
