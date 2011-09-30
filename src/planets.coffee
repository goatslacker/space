class Planets

  constructor: ->
    i = 0
    while i < Game.PLANETS
      radius = Math.ceil(Math.random() * Planet.MAX_RADIUS) + Planet.MIN_RADIUS
      color = game.getColor()

      loop
        x = game.getX()
        y = game.getY()
        break if @planetDoesntExist x, y

      @addPlanet x, y, radius, color
      i += 1

  planets: []

  addPlanet: (x, y, radius, color) ->
    planet = new Planet x, y, radius, color
    @planets.push planet
    planet.draw()

  planetDoesntExist: (x, y) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      o = planet.hwxy()
      print game.rect_collision o, x, y
      return false if game.rect_collision o, x, y
      i += 1

    true
