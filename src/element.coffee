# any element on the grid
class Element
  constructor: (@x, @y) ->
    throw "Coordinates are required" if @x is null or @y is null

  # checks if element is off the screen
  isOffScreen: ->
    @x > Game.WIDTH or @y > Game.HEIGHT or @x < 0 or @y < 0

  # checks if element has collided with a planet
  hasCollided: ->
    !planets.planetDoesntExist(@x, @y, @radius)

  # main caller to animate a given object
  animate: (angle, speed) ->
    @angle = angle
    @vel = speed

    # recalculate the path
    [@vx, @vy] = @getPath()

    Game.animate((delta) =>
      # apply gravitational pull from planets to x, y
      @__applyGravity()

      # update the object`s x and y
      @__updateXY()
      # move the object on screen
      @__translate delta

      # implement a willCollide method which checks where the ball will be at the next frame
      # and determines if the ball will collide
      # if it`s true, then update the ball`s positioning
      false if @isOffScreen() or @hasCollided()
    )

  getAngle: (x, y) ->
    Math.atan2(y - @y, x - @x) * (180 / Math.PI)

  # returns the point of the path based on a radian and it`s velocity
  getPath: ->
    # convert to degrees
    angle = @angle * (Math.PI / 180)

    x = @vel * Math.cos angle
    y = @vel * Math.sin angle

    [x, y]


  # "private" methods
  # using the Python PEP-8

  # applies gravity from sorrounding planets
  __applyGravity: ->
    [x, y] = planets.getGravitationalPull @
    @vx += x
    @vy += y

  # updates the coordinates of the element
  __updateXY: ->
    @x += @vx
    @y += @vy

  # moves the object on the screen
  __translate: (delta) ->
    @value.translate(@vx * delta / 16, @vy * delta / 16)

