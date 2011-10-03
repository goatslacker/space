class Explosion extends Element

  constructor: (@x, @y, @angle) ->
    throw "Angle was not set" if angle is null

    particles_amt = Math.ceil(Math.random() * (Explosion.MAX_PARTICLES - Explosion.MIN_PARTICLES)) + Explosion.MIN_PARTICLES

    i = 0

    while i < particles_amt
      particle_size = Math.ceil(Math.random() * (Explosion.MAX_SIZE - Explosion.MIN_SIZE)) + Explosion.MIN_SIZE
      particle_color = 0.1

      particle = game.raph.rect(@x + i, @y + i, particle_size, particle_size).attr(
        fill: "hsb(#{particle_color}, 1, 1)",
        stroke: "none"
      )

      @particles.push particle

      i += 1

  particles: []

Explosion.MIN_PARTICLES = 100
Explosion.MAX_PARTICLES = 200
Explosion.COLORS = []
Explosion.MIN_SIZE = 1
Explosion.MAX_SIZE = 3
Explosion.TIME = 250
