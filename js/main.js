// Generated by CoffeeScript 1.9.0
(function() {
  var animate, draw;

  window.onload = function() {
    window.board = new Board(document.getElementById("board"));
    draw();
    animate();
    window.onresize = function() {
      if (board) {
        return board.setSize();
      }
    };
    window.onkeydown = function(e) {
      if (board.players[0].type === "player") {
        if (e.keyCode === 83) {
          board.players[0].v += board.players[0].height / 10;
        }
        if (e.keyCode === 87) {
          board.players[0].v -= board.players[0].height / 10;
        }
      }
      if (board.players[1].type === "player") {
        if (e.keyCode === 40) {
          board.players[1].v += board.players[1].height / 10;
        }
        if (e.keyCode === 38) {
          return board.players[1].v -= board.players[1].height / 10;
        }
      }
    };
    document.getElementById("board").onmousedown = function(e) {
      return board.mouse.pressed = true;
    };
    document.getElementById("board").onmouseup = function(e) {
      return board.mouse.pressed = false;
    };
    return document.getElementById("board").onmousemove = function(e) {
      board.mouse.x = (e.pageX - board.canvas.offsetLeft) * board.u;
      return board.mouse.y = (e.pageY - board.canvas.offsetTop) * board.u;
    };
  };

  animate = function() {
    window.board.animate();
    return window.setTimeout(animate, 1000 / 60);
  };

  draw = function() {
    var fps;
    if (typeof draw.lastTime === 'undefined') {
      draw.lastTime = new Date().getTime();
    } else {
      fps = 1000 / (new Date().getTime() - draw.lastTime);
      board.fps = fps.toFixed(2) + ' fps';
      draw.lastTime = new Date().getTime();
    }
    window.board.draw();
    return requestAnimationFrame(draw);
  };

  window.requestAnimationFrame = (function() {
    return window.requestAnimationFrame || window.webkitrequestAnimationFrame || window.mozrequestAnimationFrame || function(cback) {
      return window.setTimeout(cback, 1000 / 60);
    };
  })();

}).call(this);
