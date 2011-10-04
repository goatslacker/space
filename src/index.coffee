# initialize components
game = null

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

# listeners
document.addEventListener("keypress", ((e) ->

  fireMissile = ->
    missile = new SmallMissile 500, 765
    missile.fire -90, 0.5

  switch e.keyCode
    when 32 then fireMissile()

), false)

#spaceship = new Spaceship 200, 200
#spaceship.draw()
