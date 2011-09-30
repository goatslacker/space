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

  planetDoesntExist: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]

      c1 = planet.metrics()
      c2 = (
        x: x,
        y: y,
        radius: radius
      )

      return false if game.circle_collision c1, c2
      i += 1

    true
