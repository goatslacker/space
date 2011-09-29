(function() {
  var Game, Planet, Planets, Star, Stars, c, game, planets, stars;
  Game = (function() {
    Game.prototype.raph = null;
    Game.prototype.WIDTH = 1024;
    Game.prototype.HEIGHT = 768;
    function Game() {
      this.raph = Raphael(0, 0, this.WIDTH, this.HEIGHT);
    }
    Game.prototype.rnd = function() {
      return Math.random();
    };
    Game.prototype.getX = function() {
      return this.rnd() * this.WIDTH;
    };
    Game.prototype.getY = function() {
      return this.rnd() * this.HEIGHT;
    };
    return Game;
  })();
  Game.animate = function(render, element) {
    var animation, lastFrame, running;
    lastFrame = +new Date;
    running = void 0;
    animation = function(now) {
      if (running !== false) {
        requestAnimationFrame(animation, element);
        running = render(now - lastFrame);
        return lastFrame = now;
      }
    };
    return animation(lastFrame);
  };
  Planet = (function() {
    function Planet(x, y, size, color) {
      this.x = x;
      this.y = y;
      this.size = size;
      this.color = color;
    }
    Planet.prototype.draw = function() {
      return game.raph.circle(this.x, this.y, this.size).attr({
        fill: "hsb(" + this.color + ", .7, .9)",
        stroke: "none"
      });
    };
    return Planet;
  })();
  Planet.MAX_SIZE = 50;
  Planet.MIN_SIZE = 30;
  Planets = (function() {
    function Planets() {
      var color, i, size;
      i = 0;
      while (i < 5) {
        size = Math.ceil(Math.random() * Planet.MAX_SIZE) + Planet.MIN_SIZE;
        color = (Math.floor(Math.random() * 10) + 1) / 10;
        this.addPlanet(game.getX(), game.getY(), size, color);
        i += 1;
      }
    }
    Planets.prototype.planets = [];
    Planets.prototype.addPlanet = function(x, y, size, color) {
      var planet;
      planet = new Planet(x, y, size, color);
      this.planets.push(planet);
      return planet.draw();
    };
    return Planets;
  })();
  Star = (function() {
    function Star(x, y) {
      this.x = x;
      this.y = y;
    }
    Star.prototype.draw = function() {
      return game.raph.circle(this.x, this.y, 1).attr({
        fill: "hsb(1, .1, 1)",
        stroke: "none"
      });
    };
    return Star;
  })();
  Stars = (function() {
    function Stars() {
      var i;
      i = 0;
      while (i < 1000) {
        this.addStar(game.getX(), game.getY());
        i += 1;
      }
    }
    Stars.prototype.addStar = function(x, y) {
      var star;
      star = new Star(x, y);
      return star.draw();
    };
    return Stars;
  })();
  document.body.style.background = "black";
  this.requestAnimationFrame = (function() {
    return window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || window.oRequestAnimationFrame;
  })();
  game = new Game;
  stars = new Stars;
  planets = new Planets;
  c = game.raph.circle(500, 738, 30).attr({
    fill: "hsb(1, 1, 1)",
    stroke: "none"
  });
  Game.animate((function(delta) {
    return c.translate(0, -1 * delta / 16);
  }), c);
}).call(this);
