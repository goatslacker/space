# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  isOffScreen: (x, y) ->
    x > Game.WIDTH or y > Game.HEIGHT or x < 0 or y < 0

  animate: (el, getXY) ->
    Game.animate((delta) =>
      [x, y] = getXY()
      el.translate(x * delta / 16, y * delta / 16)

      false if @isOffScreen(x, y)
    )
