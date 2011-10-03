class Missile extends Element

  constructor: (@x, @y, @radius = 5, @color = 10) ->
    super @x, @y

    color = @color / 10

    size = @radius * 2

    @verts = (
      m: [@x, @y],
      l1: [@x + size, @y - @radius],
      l2: [@x, @y - size],
      l3: [@x, @y]
    )

    svgstring = "M#{@verts.m[0]},#{@verts.m[1]}L#{@verts.l1[0]},#{@verts.l1[1]}L#{@verts.l2[0]},#{@verts.l2[1]}L#{@verts.l3[0]},#{@verts.l3[1]}"

    @value = game.raph.path(svgstring).attr(
      fill: "hsb(#{color}, 1, 1)",
      stroke: "none"
    )

  speed: 5
  mass: 2.5

  # fires the missile
  # angle is meant to be part of this.
  fire: (@angle = 0, power = 1) ->
    # power is an float from 0 - 1
    speed = @speed * power

    @value.rotate @angle

    @animate speed
