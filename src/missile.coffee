class Missile extends Element

  constructor: (@x, @y, @size = 5, @color = 10) ->
    super @x, @y

    color = @color / 10

    @value = game.raph.circle(@x, @y, @size).attr(
      fill: "hsb(#{color}, 1, 1)",
      stroke: "none"
    )

  speed: 5
  acceleration: 10
  weight: 100

  fire: (angle = 0, power = 1) ->
    speed = @speed * power

    @animate @value, angle, speed