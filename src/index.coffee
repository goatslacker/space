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
  game

# initialize components
game = new Game
game.init()

# testing
#game.planets.destroyAll()
#game.planets.addPlanet 300, 300, 70
#game.planets.planets[0].showGravity()

missile = new SmallMissile 500, 565
missile.fire -90, 0.5

explosion = new Explosion 200, 200, -90
