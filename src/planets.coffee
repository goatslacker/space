class Planets

  constructor: ->
    i = 0
    while i < Game.PLANETS
      radius = Planet.getRadius()
      color = game.getColor()

      # do not draw planets on top of other planets
      loop
        x = game.getX()
        y = game.getY()
        break if @planetDoesntExist x, y, radius

      # add the planet
      @addPlanet x, y, radius, color
      i += 1

  planets: []

  # adds a planet on to the screen and then pushes it into the list
  addPlanet: (x, y, radius, color) ->
    planet = new Planet x, y, radius, color
    @planets.push planet
    planet.draw()

  # kills all planets in an anticlimatic way
  destroyAll: ->
    i = 0

    while i < @planets.length
      planet = @planets.shift()
      planet.value.remove()

  # returns gravitational pull an element has in relation
  # to all of the planets on screen
  getGravitationalPull: (el) ->
    # initialize force of gravity X and Y
    fgX = 0
    fgY = 0

    # destructure the element into x, y, radius, speed and mass
    {x, y, radius, speed, mass} = el

    i = 0

    # loop through all planets
    while i < @planets.length
      planet = @planets[i]

      dX = planet.x - x
      dY = planet.y - y
      dist = planet.gravitational_pull + radius

      theta = Math.atan2(dY, dX)

      rsq = (dY * dY) + (dX * dX)
      dsq = dist * dist

      # if the element is in the planet`s gravitational field
      if dsq / rsq > 1
        # then gravity affects it`s course
        force = Game.GRAVITY * mass * planet.mass / rsq
        fgX += force * Math.cos(theta)
        fgY += force * Math.sin(theta)

      i += 1

    # send the results back to the element
    # and adjust it`s trajectory
    vX = (fgX / mass) * speed
    vY = (fgY / mass) * speed

    [vX, vY]

  # determines if a planet exists in coordinates provided
  planetDoesntExist: (x, y, radius) ->
    i = 0

    while i < @planets.length
      planet = @planets[i]
      return false if game.circle_collision(planet, (x: x, y: y, radius: radius))
      i += 1

    true
