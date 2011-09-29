class Planets

  constructor: ->
    i = 0
    while i < 5
      size = Math.ceil(Math.random() * Planet.MAX_SIZE) + Planet.MIN_SIZE
      color = (Math.floor(Math.random() * 10) + 1) / 10
      @addPlanet game.getX(), game.getY(), size, color
      i += 1

  planets: []

  addPlanet: (x, y, size, color) ->
    planet = new Planet x, y, size, color
    @planets.push planet
    planet.draw()
