document.body.style.background = "black"

@requestAnimationFrame = (->
  window.mozRequestAnimationFrame    ||
  window.webkitRequestAnimationFrame ||
  window.msRequestAnimationFrame     ||
  window.oRequestAnimationFrame
)()

# initialize components
game = new Game
stars = new Stars
planets = new Planets


# testing
c = game.raph.circle(500, 738, 30).attr(
  fill: "hsb(1, 1, 1)",
  stroke: "none"
)

Game.animate(((delta) ->
  c.translate(0, -1 * delta / 16)
), c)
