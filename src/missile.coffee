class Missile extends Element

  constructor: (@x, @y, @radius = 5, @color = 10) ->
    super @x, @y

    color = @color / 10

    @value = game.raph.circle(@x, @y, @radius).attr(
      fill: "hsb(#{color}, 1, 1)",
      stroke: "none"
    )

  speed: 5
  mass: 2.5

  # fires the missile
  fire: (angle = 0, power = 1) ->
    # power is an float from 0 - 1
    speed = @speed * power

    @animate angle, speed
