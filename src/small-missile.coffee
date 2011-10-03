class SmallMissile extends Missile

  constructor: (@x, @y) ->
    super @x, @y, 5

  speed: 10
  mass: 1.5
