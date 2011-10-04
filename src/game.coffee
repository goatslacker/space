class Game
  init: ->
    @raph = Raphael 0, 0, Game.WIDTH, Game.HEIGHT

    # init components
    @stars = new Stars
    @planets = new Planets

  rnd: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  getX: ->
    @rnd 0, Game.WIDTH

  getY: ->
    @rnd 0, Game.HEIGHT

  eitheror: (case1, case2) ->
    opt = Math.round(Math.random())

    if opt is 1
      case1
    else
      case2

  createSVGString: (verts) ->
    str = "M#{verts.m[0]}, #{verts.m[1]}"

    verts.l.forEach((vert) ->
      str += "L#{vert[0]}, #{vert[1]}"
    )

    str

  getColor: ->
    (@rnd 1, 10) / 10

  # determine if there has been a collision
  circle_collision: (c1, c2) ->
    dx = c1.x - c2.x
    dy = c1.y - c2.y

    dist = c1.radius + c2.radius

    rsq = (dx * dx) + (dy * dy)
    dsq = dist * dist

    rsq <= dsq

  # collisions for rectangles
  rect_collision: (box, x, y) ->
    return true if x > box.x and x < (box.x + box.width) and y > box.y and y < (box.y + box.height)
    return false

# TODO: animations should be performed server-side. Client-side we just update the positions
Game.animate = (render, element) ->
  lastFrame = +new Date
  running = undefined

  animation = (now) ->
    if running != false
      requestAnimationFrame animation, element

      # if delta (now - lastFrame) is less than 160 then we render the next frame
      running = render(now - lastFrame) if (now - lastFrame) < 160
      lastFrame = now

  animation lastFrame

Game.WIDTH = 1024 #5000
Game.HEIGHT = 768 #5000
Game.GRAVITY = 10
Game.PLANETS = 5
Game.STARS = 1000
