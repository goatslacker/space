class SmallMissile extends Missile

  constructor: (@x, @y) ->
    super @x, @y, 3

  speed: 10
  acceleration: 100
