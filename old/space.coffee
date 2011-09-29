document.body.style.background = "black"

class Game
  r: null
  WIDTH: 1024
  HEIGHT: 768

  constructor: ->
    @r = Raphael 0, 0, @WIDTH, @HEIGHT

  rnd: ->
    Math.random()

  getX: ->
    @rnd() * @WIDTH

  getY: ->
    @rnd() * @HEIGHT

class Planet

  constructor: (@x, @y, @size, @color) ->

  draw: ->
    game.r.circle(@x, @y, @size).attr(
      fill: "hsb(#{@color}, .7, .9)"
      stroke: "none"
    )

class Planets

  constructor: ->
    i = 0
    while i < 5
      size = Math.ceil(Math.random() * 50) + 30
      color = (Math.floor(Math.random() * 10) + 1) / 10
      @addPlanet game.getX(), game.getY(), size, color
      i += 1

  planets: []

  addPlanet: (x, y, size, color) ->
    planet = new Planet x, y, size, color
    @planets.push planet
    planet.draw()

class Star

  constructor: (@x, @y) ->

  draw: ->
    game.r.circle(@x, @y, 1).attr(
      fill: "hsb(1, .1, 1)"
      stroke: "none"
    )

class Stars

  constructor: ->
    i = 0
    while i < 1000
      @addStar game.getX(), game.getY()
      i += 1

  addStar: (x, y) ->
    star = new Star x, y
    star.draw()

game = new Game
stars = new Stars
planets = new Planets
