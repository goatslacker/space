class Planets

  constructor: ->
    i = 0
    while i < Game.PLANETS
      radius = Planet.getRadius()
      color = game.getColor()

      loop
        x = game.getX()
        y = game.getY()
        break if @planetDoesntExist x, y, radius

      @addPlanet x, y, radius, color
      i += 1

  planets: []

  addPlanet: (x, y, radius, color) ->
    planet = new Planet x, y, radius, color
    @planets.push planet
    planet.draw()

  destroyAll: ->
    i = 0

    while i < @planets.length
      planet = @planets.shift()
      planet.value.remove()

  getGravitationalPull: (el) ->
    fgX = 0
    fgY = 0

    {x, y, radius, speed, mass} = el

    i = 0

    while i < @planets.length
      planet = @planets[i]

      dX = planet.x - x
      dY = planet.y - y
      dist = planet.gravitational_pull + radius

      theta = Math.atan2(dY, dX)

      rsq = (dY * dY) + (dX * dX)
      dsq = dist * dist

      if dsq / rsq > 1
        force = Game.GRAVITY * mass * planet.mass / rsq
        fgX += force * Math.cos(theta)
        fgY += force * Math.sin(theta)

      i += 1

    vX = (fgX / mass) * speed
    vY = (fgY / mass) * speed

    [vX, vY]

  planetDoesntExist: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      return false if game.circle_collision(planet, (x: x, y: y, radius: radius))
      i += 1

    true
