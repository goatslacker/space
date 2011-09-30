class SmallMissile extends Missile

  constructor: (@x, @y) ->
    super @x, @y, 3

  fX: Game.WIDTH / 100
  fY: Game.HEIGHT / 100

  fire: (angle = 0, power = 100) ->
    [x, y] = @getDestinationXY(angle, @fX * power, @fY * power)

    super x, y
