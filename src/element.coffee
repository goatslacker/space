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

  inGravity: ->
    pl = planets.isInGravitationalField(@x, @y, @radius)
    if pl
      # pull the gravity and planet
      { gravity, planet } = pl
#      print gravity

      GRAVITY = gravity / Game.GRAVITY

      # use the planets coordinates
      x = planet.x
      y = planet.y

      # get the new angle we will point to
      angle = @getAngle x, y
#      print gravity
#      print angle
#      print @angle

      speed = @vel - (@vel * GRAVITY)

      # speed should accelerate towards object
      print speed * Math.sin @vy

      # recalculate the path based on the gravity

  # incremental counter used for acceleration
  start: 0

  # gets the current speed based on acceleration
  accelerate: (delta, x, y) ->
    if (@start < @acceleration)
      @vx = (@start / @acceleration) * x
      @vy = (@start / @acceleration) * y

      # increment the start
      @start += delta
    else
      @vx = x
      @vy = y

  # updates the coordinates of the element
  updateXY: ->
    @x += @vx
    @y += @vy

  # moves the object on the screen
  # TODO make private
  translate: (delta) ->
    @value.translate(@vx * delta / 16, @vy * delta / 16)

  # main caller to animate a given object
  animate: (angle, speed) ->
    @angle = angle
    @vel = speed

    # recalculate the path
    [@vx, @vy] = @getPath()

    Game.animate((delta) =>
#      @accelerate delta, x, y
      @updateXY()
      @translate delta

      @inGravity()

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
