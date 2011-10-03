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

document.addEventListener("keypress", ((e) ->

  fireMissile = ->
    missile = new SmallMissile 500, 765
    missile.fire -90, 0.5

  switch e.keyCode
    when 32 then fireMissile()

), false)
