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

    @animate speed

  explode: ->
    if @value
      @value.remove()
      @value = null
      crater = game.raph.circle(@x, @y, @mass * 20).attr(
        fill: "black",
        stroke: "none"
      )
      explosion = new Explosion @x, @y, 0
