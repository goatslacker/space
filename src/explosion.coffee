class Explosion extends Element

  constructor: (@x, @y) ->
    super @x, @y

    i = 0
    amount = game.rnd Explosion.MIN_PARTICLES, Explosion.MAX_PARTICLES

    while i < amount
      { color, verts } = @getProperties()

      svgstring = "M#{verts.m[0]},#{verts.m[1]}L#{verts.l[0][0]},#{verts.l[0][1]}"

      particle = game.raph.path(svgstring).attr(
        stroke: "#{color}"
      )

      @particles.push((
        value: particle,
        x: @x,
        y: @y,
        verts: verts
      ))

      i += 1

    @animate()

  particles: []

  getProperties: ->
    size = game.rnd Explosion.MIN_SIZE, Explosion.MAX_SIZE
    color = Explosion.COLORS[Math.round(Math.random())]

    x = game.rnd(@x - Explosion.RADIUS, @x + Explosion.RADIUS)
    y = game.rnd(@y - Explosion.RADIUS, @y + Explosion.RADIUS)

    xSize = size * game.eitheror -1, 1
    ySize = size * game.eitheror -1, 1

    verts = (
      m: [x, y],
      l: [
        [x + xSize, y + ySize]
      ]
    )

    { color, verts }

  destroyAllParticles: ->
    i = 0
    particles = @particles.length

    while i < particles
      particle = @particles.shift()
      particle.value.remove()
      i += 1

    @particles = []

  animate: ->
    ttl = 0
    particles = @particles.length

    Game.animate((delta) =>
      ttl += delta
      i = 0

      while i < particles
        @__setTranslation i
        i += 1

        # move the object on screen
        @__translate delta
        @__opaque ttl

      false if @done ttl
    )

  done: (ttl) ->
    over = ttl > Explosion.TIME

    if over
      @destroyAllParticles()

    over

  __setTranslation: (i) ->
    { @value, verts } = @particles[i]
    [ x, y ] = verts.l[0]
    @angle = @getAngle x, y
    [@vx, @vy] = @getPath Explosion.SPEED

  __opaque: (ttl) ->
    opacity = 1 - (ttl / Explosion.TIME)
    @value.attr(( opacity: opacity ))

Explosion.RADIUS = 25
Explosion.SPEED = 2
Explosion.MIN_PARTICLES = 200
Explosion.MAX_PARTICLES = 500
Explosion.COLORS = ["red", "orange"]
Explosion.MIN_SIZE = 2
Explosion.MAX_SIZE = 4
Explosion.TIME = 500
