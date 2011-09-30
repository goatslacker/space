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
  translate: (delta) ->
    @value.translate(@vx * delta / 16, @vy * delta / 16)

  # main caller to animate a given object
  animate: (angle, speed) ->
    [x, y] = @getPath angle, speed

    Game.animate((delta) =>
      @accelerate delta, x, y
      @updateXY()
      @translate delta

      # implement a willCollide method which checks where the ball will be at the next frame
      # and determines if the ball will collide
      # if it`s true, then update the ball`s positioning
      false if @isOffScreen() or @hasCollided()
    )

  # returns the point of the path based on a radian and it`s speed
  getPath: (angle, speed) ->
    angle = angle * (Math.PI / 180)

    x = speed * Math.cos angle
    y = speed * Math.sin angle

    [x, y]
