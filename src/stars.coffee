class Stars

  constructor: ->
    i = 0
    while i < 1000
      @addStar game.getX(), game.getY()
      i += 1

  addStar: (x, y) ->
    star = new Star x, y
    star.draw()
