class Explosion extends Element

  constructor: (@x, @y, @angle) ->
    super @x, @y
    throw "Angle was not set" if angle is null

    amount = game.rnd Explosion.MIN_PARTICLES, Explosion.MAX_PARTICLES

    i = 0

    while i < amount
      size = game.rnd Explosion.MIN_SIZE, Explosion.MAX_SIZE
      color = Explosion.COLORS[Math.round(Math.random())]

      x = game.rnd(@x - Explosion.RADIUS, @x + Explosion.RADIUS)
      y = game.rnd(@y - Explosion.RADIUS, @y + Explosion.RADIUS)

      xSize = size * game.eitheror -1, 1
      ySize = size * game.eitheror -1, 1

      verts = (
        m: [x, y],
        l: [x + xSize, y + ySize]
      )

      svgstring = "M#{verts.m[0]},#{verts.m[1]}L#{verts.l[0]},#{verts.l[1]}"

      particle = game.raph.path(svgstring).attr(
        stroke: "#{color}"
      )

      @particles.push particle

      i += 1

  particles: []

Explosion.RADIUS = 20
Explosion.MIN_PARTICLES = 100
Explosion.MAX_PARTICLES = 200
Explosion.COLORS = ["red", "orange"]
Explosion.MIN_SIZE = 2
Explosion.MAX_SIZE = 4
Explosion.TIME = 250
