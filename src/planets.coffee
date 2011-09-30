class Planets

  constructor: ->
    i = 0
    while i < Game.PLANETS
      size = Math.ceil(Math.random() * Planet.MAX_SIZE) + Planet.MIN_SIZE
      color = game.getColor()
      @addPlanet game.getX(), game.getY(), size, color
      i += 1

  planets: []

  addPlanet: (x, y, size, color) ->
    planet = new Planet x, y, size, color
    @planets.push planet
    planet.draw()
