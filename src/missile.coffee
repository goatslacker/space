class Missile extends Element

  constructor: (@x, @y, @radius = 5, @color = 10) ->
    super @x, @y

    color = @color / 10

    @verts = (
      m: [@x, @y],
      l1: [@x + 10, @y - 5],
      l2: [@x, @y - 10],
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
  fire: (angle = 0, power = 1) ->
    # power is an float from 0 - 1
    speed = @speed * power

    @animate angle, speed
