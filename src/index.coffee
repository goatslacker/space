# setup
document.body.style.background = "black"

# globals

@requestAnimationFrame = (->
  window.mozRequestAnimationFrame    ||
  window.webkitRequestAnimationFrame ||
  window.msRequestAnimationFrame     ||
  window.oRequestAnimationFrame
)()

# debugging
@print = (msg...) ->
  console.log msg...

@debug = ->
  (missile: missile, planets: planets, game: game, stars: stars)

# initialize components
game = new Game
stars = new Stars
planets = new Planets

# testing
#planets.destroyAll()
#planets.addPlanet 300, 300, 70
#planets.planets[0].showGravity()

missile = new SmallMissile 500, 565
#missile.fire -90, 0.5
