# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  isOffScreen: ->
    @x > Game.WIDTH or @y > Game.HEIGHT or @x < 0 or @y < 0

  hasCollided: ->
    !planets.planetDoesntExist(@x, @y, @radius)

  animate: (el, angle, speed) ->
    [x, y] = @getPath angle, speed

    Game.animate((delta) =>
      @x += x
      @y += y

      el.translate(x * delta / 16, y * delta / 16)

      false if @isOffScreen() or @hasCollided()
    )

  getPath: (angle, speed) ->
    angle = angle * (Math.PI / 180)

    x = speed * Math.cos angle
    y = speed * Math.sin angle

    [x, y]
