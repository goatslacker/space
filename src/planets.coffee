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

  isInGravitationalField: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      gravity = game.circle_field((x: planet.x, y: planet.y, radius: planet.gravitational_pull ), (x: x, y: y, radius: radius))

      if gravity > 1
        return (gravity: gravity, planet: planet)

      i += 1

    null

  planetDoesntExist: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      return false if game.circle_collision(planet, (x: x, y: y, radius: radius))
      i += 1

    true
