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
missile = new SmallMissile 500, 765
missile.fire 270, 0.5
