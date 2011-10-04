# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  # checks if element is off the screen
  isOffScreen: ->
    @x > game.width or @y > game.height or @x < 0 or @y < 0

  # is still alive?
  doesntExist: ->
    @value is null

  # main caller to animate a given object
  animate: (speed, done) ->
    # recalculate the path
    [@vx, @vy] = @getPath speed
    areWeDoneYet = done.bind @

    Game.animate((delta) =>
      # apply gravitational pull from planets to x, y
      @__applyGravity()

      # update the object`s x and y
      @__updateXY()
      # move the object on screen
      @__translate delta

      areWeDoneYet delta
    )

  getAngle: (x, y) ->
    Math.atan2(y - @y, x - @x) * (180 / Math.PI)

  # returns the point of the path based on a radian and it`s velocity
  getPath: (speed) ->
    # convert to degrees
    angle = @angle * (Math.PI / 180)

    x = speed * Math.cos angle
    y = speed * Math.sin angle

    [x, y]


  # "private" methods
  # using the Python PEP-8

  # applies gravity from sorrounding planets
  __applyGravity: ->
    # retrieve the pull
    [x, y] = game.planets.getGravitationalPull @

    # store the current value
    vx = @vx
    vy = @vy

    # increment the velocity
    @vx += x
    @vy += y

    # rotate the element
    @__rotate vx, vy

  # rotates the element given an X and Y coordinates
  __rotate: (x, y) ->
    @value.rotate (Raphael.angle(x, y, @vx, @vy, 0, 0) * -1)

  # updates the coordinates of the element
  __updateXY: ->
    @x += @vx
    @y += @vy

  # moves the object on the screen
  __translate: (delta) ->
    @value.translate(@vx * delta / 16, @vy * delta / 16)

