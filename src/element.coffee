# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  animate: (el, stop) ->
    Game.animate((delta) ->
      el.y = el.y - 1
      el.value.translate(0, -1 * delta / 16)

      # stop animation
      false if el.y < stop
    )

  getDestinationXY: (a, x, y) ->
    a = a * (Math.PI / 180)

    x = @x + x * Math.cos a
    y = @y + y * Math.sin a

    [x, y]
