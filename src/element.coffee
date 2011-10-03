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

  # is still alive?
  doesntExist: ->
    @value is null

  timer: 0

  # main caller to animate a given object
  animate: (speed) ->
    # recalculate the path
    [@vx, @vy] = @getPath speed

    Game.animate((delta) =>
      # update the TTL
      @__updateTTL delta

      # apply gravitational pull from planets to x, y
      @__applyGravity()

      # update the object`s x and y
      @__updateXY()
      # move the object on screen
      @__translate delta

      # implement a willCollide method which checks where the ball will be at the next frame
      # and determines if the ball will collide
      # if it`s true, then update the ball`s positioning
      false if @isOffScreen() or @hasCollided() or @doesntExist()
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

  # missiles can only live for so long
  __updateTTL: (delta) ->
    @timer += delta

    if @timer > @time
      @explode()

  # applies gravity from sorrounding planets
  __applyGravity: ->
    [x, y] = planets.getGravitationalPull @
    @vx += x
    @vy += y

  # updates the coordinates of the element
  __updateXY: ->
    @x += @vx
    @y += @vy
    @value.rotate @vx # FIXME

  # moves the object on the screen
  __translate: (delta) ->
    @value.translate(@vx * delta / 16, @vy * delta / 16)

