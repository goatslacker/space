document.body.style.background = 'black';

(function (Raphael) {
  // 960 x 640
  // 1024 x 768
  const WIDTH = 1024;
  const HEIGHT = 768;

  var rb = function (str, obj) {
    Object.keys(obj).forEach(function (prop) {
      if (obj.hasOwnProperty(prop)) {
        str = str.replace(new RegExp('#{' + prop + '}', 'g'), typeof obj[prop][1] === 'f' ? obj[prop]() : obj[prop]);
      }
    });

    return str;
  };

  var R = Raphael(0, 0, WIDTH, HEIGHT);

  var getX = function () {
    return Math.random() * WIDTH;
  };

  var getY = function () {
    return Math.random() * HEIGHT;
  };

  function planet(x, y, l, t) {
    var c = R.circle(x, y, l).attr({
      fill: "hsb(" + t.join(",") + ")",
      stroke: "none"
    });
  }

  function planets() {
    var i = 0;
    var l = 1;
    var c = 0;

    for (i; i < 5; i += 1) {
      l = Math.ceil(Math.random() * 50) + 30;
      c = (Math.floor(Math.random() * 10) + 1) / 10;

//      planet(getX(), getY());

      planet(getX(), getY(), l, [c, .7, .9]);
    }
  }

  function star(x, y) {
    var c = R.circle(x, y, 1).attr({
      fill: "hsb(1, .1, 1)",
      stroke: "none"
    });
  }

  function stars() {
    for (var i = 0; i < 1000; i += 1) {
      star(getX(), getY());
    }
  }

  // draws space
  (function space() {
    stars();
    planets();
  }());

}(Raphael.ninja()));
