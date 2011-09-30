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

  planetDoesntExist: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      return false if game.circle_collision(planet, (x: x, y: y, radius: radius))
      i += 1

    true
