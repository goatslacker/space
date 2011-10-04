# Based on Dave Bollinger`s work

class Spaceship

  constructor: ->
    @ship = ( solid: [], cockpit: [], body: [] )

    # map the ship
    { empty, solid, cockpit, body } = @map this

    # turn on all solids first
    solid.forEach((block) =>
      @ship.solid.push block
    )

    # dynamically build cockpit and body
    cockpit.forEach @create "cockpit"
    body.forEach @create "body"

  toString: ->
    @ship

  draw: ->
    { solid, cockpit, body } = @ship

    drawPixels = (block) =>
      @drawPixel block[0], block[1]

    solid.forEach drawPixels
    cockpit.forEach drawPixels
    body.forEach drawPixels

  # TODO do SVG path instead
  drawPixel: (x, y) ->
    sx = x * Spaceship.SIZE
    sy = y * Spaceship.SIZE
    game.raph.rect(sx, sy, Spaceship.SIZE, Spaceship.SIZE).attr(
      fill: "white"
    )

    @mirror x, y

  mirror: (x, y) ->
    sx = ((Spaceship.X * 2) - 1 - x) * Spaceship.SIZE
    sy = y * Spaceship.SIZE
    game.raph.rect(sx, sy, Spaceship.SIZE, Spaceship.SIZE).attr(
      fill: "white"
    )

  # draw`s a piece of the spaceship
  create: (section) ->
    # returns a function used by forEach when drawing
    iterator = (block) =>
      # turn on a block "randomly"
      @ship[section].push block if @isOn()

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

Spaceship.SIZE = 1.5
Spaceship.X = 6
Spaceship.Y = 12
