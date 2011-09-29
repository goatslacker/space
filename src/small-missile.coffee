class SmallMissile extends Missile

  constructor: (@x, @y) ->
    super @x, @y, 3

  fireX: Game.WIDTH / 100
  fireY: Game.HEIGHT / 100

  fire: (aim = 0, power = 100) ->
    [x, y] = @getDestinationXY(aim, @fireX * power, @fireY * power)

    console.log x, y

    super x, y

  test: (aim = 0, power = 100) ->
    @getDestinationXY(aim, @fireX * power, @fireY * power)
