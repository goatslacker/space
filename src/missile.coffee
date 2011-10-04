class Missile extends Element

  constructor: (@x = null, @y = null, @radius = @mass * 2, @color = 10) ->
    super @x, @y

    color = @color / 10

    size = @radius * 2

    @verts = (
      m: [@x, @y],
      l: [
        [@x + size, @y - @radius],
        [@x, @y - size],
        [@x, @y]
      ]
    )

    @value = game.raph.path(game.createSVGString(@verts)).attr(
      fill: "hsb(#{color}, 1, 1)",
      stroke: "none"
    )

  speed: 5
  mass: 2.5
  time: 5000

  # fires the missile
  # angle is meant to be part of this.
  fire: (@angle = 0, power = 1) ->
    # power is an float from 0 - 1
    speed = @speed * power

    @value.rotate @angle

    @animate speed, @animationComplete

  animationComplete: (delta) ->
    # update the TTL
    @__updateTTL delta

    # implement a willCollide method which checks where the ball will be at the next frame
    # and determines if the ball will collide
    # if it`s true, then update the ball`s positioning
    false if @isOffScreen() or @hasCollided() or @doesntExist()

  # checks if element has collided with a planet
  hasCollided: ->
    crash = !game.planets.planetDoesntExist(@x, @y, @radius)
    if crash is true
      @explode()

    crash

  explode: ->
    if @value
      @value.remove()
      @value = null
      crater = game.raph.circle(@x, @y, @mass * 20).attr(
        fill: "black",
        stroke: "none"
      )
      explosion = new Explosion @x, @y, 0

  timer: 0

  # missiles can only live for so long
  __updateTTL: (delta) ->
    @timer += delta

    if @timer > @time
      @explode()

