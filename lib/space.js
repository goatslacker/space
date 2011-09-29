(function() {
  var Element, Game, Missile, Planet, Planets, SmallMissile, Star, Stars, game, missile, planets, stars;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __slice = Array.prototype.slice;
  Game = (function() {
    Game.prototype.raph = null;
    function Game() {
      this.raph = Raphael(0, 0, Game.WIDTH, Game.HEIGHT);
    }
    Game.prototype.rnd = function() {
      return Math.random();
    };
    Game.prototype.getX = function() {
      return this.rnd() * Game.WIDTH;
    };
    Game.prototype.getY = function() {
      return this.rnd() * Game.HEIGHT;
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
        if ((now - lastFrame) < 160) {
          running = render(now - lastFrame);
        }
        return lastFrame = now;
      }
    };
    return animation(lastFrame);
  };
  Game.WIDTH = 1024;
  Game.HEIGHT = 768;
  Element = (function() {
    function Element(x, y) {
      this.x = x;
      this.y = y;
      if (this.x === null || this.y === null) {
        throw "Coordinates are required";
      }
    }
    Element.prototype.animate = function(el, stop) {
      return Game.animate(function(delta) {
        el.y = el.y - 1;
        el.value.translate(0, -1 * delta / 16);
        if (el.y < stop) {
          return false;
        }
      });
    };
    Element.prototype.getDestinationXY = function(aim, x, y) {
      if (aim === 360 || aim > 0 && aim < 45) {
        x = this.x - (x / (aim / 360));
        y = this.y - y;
      } else if (aim >= 45 && aim < 90) {
        x = this.x + x;
        y = this.y - (y / (aim / 45));
      } else if (aim >= 90 && aim < 135) {
        x = this.x + x;
        y = this.y + (y / (aim / 135));
      } else if (aim >= 135 && aim < 180) {
        x = this.x + (x / (aim / 135));
        y = this.y + y;
      } else if (aim >= 180 && aim < 225) {
        x = this.x + (x / (aim / 225));
        y = this.y + y;
      } else if (aim >= 225 && aim < 270) {
        x = this.x + x;
        y = this.y - (y / (aim / 225));
      } else if (aim >= 270 && aim < 315) {
        x = this.x - x;
        y = this.y - (y / (aim / 315));
      } else if (aim >= 315 && aim < 360) {
        x = this.x + (x / (aim / 315));
        y = this.y + y;
      }
      return [x, y];
    };
    return Element;
  })();
  Missile = (function() {
    __extends(Missile, Element);
    function Missile(x, y, size, color) {
      this.x = x;
      this.y = y;
      this.size = size != null ? size : 5;
      this.color = color != null ? color : 10;
      Missile.__super__.constructor.call(this, this.x, this.y);
      color = this.color / 10;
      this.value = game.raph.circle(this.x, this.y, this.size).attr({
        fill: "hsb(" + color + ", 1, 1)",
        stroke: "none"
      });
    }
    Missile.prototype.fire = function(x, y) {
      return this.animate(this, 300);
    };
    return Missile;
  })();
  SmallMissile = (function() {
    __extends(SmallMissile, Missile);
    function SmallMissile(x, y) {
      this.x = x;
      this.y = y;
      SmallMissile.__super__.constructor.call(this, this.x, this.y, 3);
    }
    SmallMissile.prototype.fireX = Game.WIDTH / 100;
    SmallMissile.prototype.fireY = Game.HEIGHT / 100;
    SmallMissile.prototype.fire = function(aim, power) {
      var x, y, _ref;
      if (aim == null) {
        aim = 0;
      }
      if (power == null) {
        power = 100;
      }
      _ref = this.getDestinationXY(aim, this.fireX * power, this.fireY * power), x = _ref[0], y = _ref[1];
      console.log(x, y);
      return SmallMissile.__super__.fire.call(this, x, y);
    };
    SmallMissile.prototype.test = function(aim, power) {
      if (aim == null) {
        aim = 0;
      }
      if (power == null) {
        power = 100;
      }
      return this.getDestinationXY(aim, this.fireX * power, this.fireY * power);
    };
    return SmallMissile;
  })();
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
  this.print = function() {
    var msg;
    msg = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return console.log.apply(console, msg);
  };
  game = new Game;
  stars = new Stars;
  planets = new Planets;
  missile = new SmallMissile(0, 0);
  print(45, missile.test(45));
  print(90, missile.test(90));
  print(180, missile.test(180));
  print(270, missile.test(270));
  print(360, missile.test(360));
}).call(this);
