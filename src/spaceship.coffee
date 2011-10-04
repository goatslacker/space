# Based on Dave Bollinger`s work

class Spaceship extends Element

  constructor: (@x = null, @y = null) ->
    super @x, @y

    @ship = ( solid: [], cockpit: [], body: [] )

    # map the ship
    { empty, solid, cockpit, body } = @map this

    # turn on all solids first
    solid.forEach((block) =>
      @ship.solid.push block
    )

    # dynamically build cockpit and body
    cockpit.forEach @__create "cockpit"
    body.forEach @__create "body"

    @draw()

  # Exports SVG Path
  toString: ->
    { solid, cockpit, body } = @ship
    svg = ""

    toSVG = (block) ->
      [x, y] = block
      sx = x * Spaceship.SIZE
      sy = y * Spaceship.SIZE

      mx = ((Spaceship.X * 2) - 1 - x) * Spaceship.SIZE

      # base
      svg += "M#{sx}, #{sy}L#{sx + 1}, #{sy + 1}"
      # mirror
      svg += "M#{mx}, #{sy}L#{mx + 1}, #{sy + 1}"

    solid.forEach toSVG
    cockpit.forEach toSVG
    body.forEach toSVG

    svg

  # draws the spaceship onto the screen
  draw: ->
    { solid, cockpit, body } = @ship

    # create a set of rectangles
    @set = game.raph.set()

    # draw the pixels!
    solid.forEach @__drawPixels @getColor()
    cockpit.forEach @__drawPixels @getColor()
    body.forEach @__drawPixels @getColor()

  map: ->
    # blocks that are always empty
    empty = [
      [0, 0], [1, 0], [2, 0], [3, 0],
      [0, 1], [1, 1], [2, 1],
      [0, 2], [1, 2], [2, 2],
      [0, 3], [1, 3],
      [0, 4], [1, 4],
      [0, 5]
    ]

    # blocks that are always solid
    solid = [
      [5, 2], [5, 3], [5, 4], [5, 9]
    ]

    # blocks that form the cockpit, can be 1/0
    cockpit = [
      [4, 5], [4, 6], [4, 7],
      [5, 5], [5, 6], [5, 7]
    ]

    # blocks that form the body, can be 1/0
    body = [
      [4, 1], [5, 1],
      [4, 2],
      [3, 3], [4, 3],
      [3, 4], [4, 4],
      [2, 5], [3, 5], [4, 5],
      [1, 6], [2, 6], [3, 6],
      [1, 7], [2, 7], [3, 7],
      [1, 8], [2, 8], [3, 8],
      [1, 9], [2, 9], [3, 9], [4, 9],
      [3, 10], [4, 10], [5, 10]
    ]

    # return the object
    { empty, solid, cockpit, body }

  # our Random generator
  isOn: ->
    Math.round(Math.random()) is 1

  # random color
  getColor: ->
    max = Spaceship.COLORS.length
    color = game.rnd(1, max) - 1
    Spaceship.COLORS[color]

  # "private" methods

  # draws colored pixels
  __drawPixels: (color) ->
    # our forEach fn
    iterator = (block) =>
      @__drawPixel block[0], block[1], color

  # draws a pixel on the screen given x and y coordinates
  __drawPixel: (x, y, color) ->
    sx = x * Spaceship.SIZE
    sy = y * Spaceship.SIZE

    # mirror the output
    @__mirror x, y, color

    # add to the set
    @__addToSet sx, sy, color


  # mirrors the image
  __mirror: (x, y, color) ->
    sx = ((Spaceship.X * 2) - 1 - x) * Spaceship.SIZE
    sy = y * Spaceship.SIZE

    @__addToSet sx, sy, color

  # draw`s a piece of the spaceship
  __create: (section) ->
    # returns a function used by forEach when drawing
    iterator = (block) =>
      # turn on a block "randomly"
      @ship[section].push block if @isOn()

  # add a rectangle with x, y coordinates to the set
  __addToSet: (x, y, color = "white") ->
    @set.push(game.raph.rect(@x + x, @y + y, Spaceship.SIZE, Spaceship.SIZE).attr(
      fill: color,
      stroke: color
    ))

Spaceship.COLORS = ["blue", "gray", "orange", "red", "white"]
Spaceship.SIZE = 1
Spaceship.X = 6
Spaceship.Y = 12
