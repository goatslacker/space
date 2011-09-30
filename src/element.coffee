# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  animate: (el, getXY) ->
    Game.animate((delta) ->
      [x, y] = getXY()
      el.translate(x * delta / 16, y * delta / 16)

      # stop animation
#      false if el.y < stop
    )
