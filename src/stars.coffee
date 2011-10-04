class Stars

  constructor: (@num_stars = Game.STARS) ->
    i = 0
    while i < @num_stars
      @addStar game.getX(), game.getY()
      i += 1

  addStar: (x, y) ->
    star = new Star x, y
    star.draw()
