class Player extends Element

  constructor: ([x, y]) ->
    @x = x or null
    @y = y or null
    super @x, @y

    @spaceship = new Spaceship @x, @y
