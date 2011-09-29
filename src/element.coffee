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

  getDestinationXY: (aim, x, y) ->
    if aim == 360 or aim > 0 and aim < 45
      y = @y - y

    else if aim >= 45 and aim < 90
      x = @x + x

    else if aim >= 90 and aim < 135
      x = @x + x

    else if aim >= 135 and aim < 180
      y = @y + y

    else if aim >= 180 and aim < 225
      y = @y + y

    else if aim >= 225 and aim < 270
      x = @x + x

    else if aim >= 270 and aim < 315
      x = @x - x

    else if aim >= 315 and aim < 360
      y = @y + y

    [x, y]
