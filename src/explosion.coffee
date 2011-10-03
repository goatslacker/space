class Explosion extends Element

  constructor: (@x, @y, @angle) ->
    super @x, @y
    throw "Angle was not set" if angle is null

    amount = game.rnd Explosion.MIN_PARTICLES, Explosion.MAX_PARTICLES

    i = 0

    while i < amount
      size = game.rnd Explosion.MIN_SIZE, Explosion.MAX_SIZE
      color = Explosion.COLORS[Math.round(Math.random())]

      x = game.rnd(@x - 10, @x + 10)
      y = game.rnd(@y - 10, @y + 10)

      particle = game.raph.rect(x, y, size, size).attr(
        fill: "hsb(#{color}, 1, 1)",
        stroke: "none"
      )

      @particles.push particle

      i += 1

  particles: []

Explosion.MIN_PARTICLES = 100
Explosion.MAX_PARTICLES = 200
Explosion.COLORS = [1, 0.1]
Explosion.MIN_SIZE = 1
Explosion.MAX_SIZE = 3
Explosion.TIME = 250
