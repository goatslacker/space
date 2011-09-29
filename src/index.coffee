# setup
document.body.style.background = "black"

# globals

@requestAnimationFrame = (->
  window.mozRequestAnimationFrame    ||
  window.webkitRequestAnimationFrame ||
  window.msRequestAnimationFrame     ||
  window.oRequestAnimationFrame
)()

@print = (msg...) ->
  console.log msg...


# initialize components
game = new Game
stars = new Stars
planets = new Planets


# testing
missile = new SmallMissile 0, 0

print 45, missile.test(45) # 1024, -768

print 90, missile.test(90) # 1024, 0

print 180, missile.test(180) # 0, 768

print 270, missile.test(270) # -1024, 0

print 360, missile.test(360) # 0, -768
