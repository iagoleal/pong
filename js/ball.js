// Generated by CoffeeScript 1.9.0
(function() {
  var Circle,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  Circle = (function() {
    Circle.prototype.r = null;

    Circle.prototype.radius = 0;

    Circle.prototype.color = "#ffc821";

    function Circle(p, _at_radius) {
      if (p == null) {
        p = {
          x: 0,
          y: 0
        };
      }
      this.radius = _at_radius != null ? _at_radius : 1;
      this.r = {
        x: p.x,
        y: p.y
      };
      this.color = {
        r: Math.round(Math.random() * 255),
        g: Math.round(Math.random() * 255),
        b: Math.round(Math.random() * 255)
      };
    }

    Circle.prototype.draw = function(c) {
      var color, i, q, _i;
      for (i = _i = 5; _i >= 1; i = --_i) {
        c.lineWidth = (i + 1) * 4 - 2;
        color = i === 0 ? '#fff' : "rgba(" + this.color.r + ", " + this.color.g + ", " + this.color.b + ", 0.2)";
        c.strokeStyle = color;
        q = i === 0 ? 0 : (5 - i) * this.height * 0.05;
        c.beginPath();
        c.arc(this.r.x, this.r.y, this.radius, 0, 2 * Math.PI, false);
        c.stroke();
        c.closePath();
      }
      c.beginPath();
      c.arc(this.r.x, this.r.y, this.radius, 0, 2 * Math.PI, false);
      c.closePath();
      return c.fill();
    };

    return Circle;

  })();

  window.Ball = (function(_super) {
    __extends(Ball, _super);

    Ball.prototype.v = null;

    Ball.prototype.speed = 7;

    function Ball(p, _at_radius, vel) {
      if (p == null) {
        p = {
          x: 0,
          y: 0
        };
      }
      this.radius = _at_radius != null ? _at_radius : 1;
      if (vel == null) {
        vel = {
          x: 0,
          y: 0
        };
      }
      Ball.__super__.constructor.call(this, p, this.radius);
      this.v = {
        x: vel.x,
        y: vel.y
      };
    }

    Ball.prototype.start = function() {
      var theta;
      theta = Math.random() * 2 * Math.PI;
      while (theta === Math.PI / 2 && theta === (3 / 2) * Math.PI) {
        theta = Math.random() * 2 * Math.PI;
      }
      this.v.x = this.speed * Math.sign(Math.cos(theta));
      return this.v.y = this.speed * Math.sin(theta);
    };

    Ball.prototype.go = function() {
      this.r.x += this.v.x;
      return this.r.y += this.v.y;
    };

    return Ball;

  })(Circle);

}).call(this);