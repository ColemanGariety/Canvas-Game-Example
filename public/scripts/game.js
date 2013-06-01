// Generated by CoffeeScript 1.6.2
var Game;

Game = (function() {
  function Game(canvasId) {
    var handleLoad, resizeCanvas,
      _this = this;

    this.stage = new createjs.Stage(canvasId);
    console.log("Started the game.");
    this.world = new createjs.Container();
    this.stage.addChild(this.world);
    handleLoad = function(event) {};
    createjs.Sound.addEventListener("fileload", handleLoad);
    createjs.Sound.registerSound("audio/rage.mp3", "ragevalley");
    this.players = [];
    resizeCanvas = function() {
      _this.stage.canvas.width = window.innerWidth;
      _this.stage.canvas.height = window.innerHeight;
      if (_this.players[0]) {
        _this.players[0].bitmap.x = window.innerWidth / 2;
        _this.players[0].bitmap.y = window.innerHeight / 2;
      }
      return _this.stage.update();
    };
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    createjs.Ticker.setFPS(30);
    createjs.Ticker.addEventListener("tick", function() {
      var player, _i, _len, _ref;

      _ref = _this.players;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        if (player.actions.movement.up === true) {
          if (_this.players[0].bitmap.currentAnimation === "standd") {
            _this.players[0].bitmap.gotoAndPlay("runu");
          }
          if ((_this.world.y + 15) > 0) {
            _this.players[0].bitmap.y -= 15;
          } else if (game.players[0].bitmap.y !== window.innerHeight / 2) {
            _this.players[0].bitmap.y -= 15;
          } else {
            if (!collision.checkPixelCollision(_this.players[0].bitmap, _this.players[1].bitmap, 0, true)) {
              _this.world.y += 15;
            }
          }
        }
        if (player.actions.movement.down === true) {
          if (_this.players[0].bitmap.currentAnimation === "standd") {
            _this.players[0].bitmap.gotoAndPlay("rund");
          }
          if ((_this.world.y - 15) < (-40000 + window.innerWidth)) {
            _this.players[0].bitmap.y += 15;
          } else if (game.players[0].bitmap.y !== window.innerHeight / 2) {
            _this.players[0].bitmap.y += 15;
          } else {
            if (!collision.checkPixelCollision(_this.players[0].bitmap, _this.players[1].bitmap, 0, true)) {
              _this.world.y -= 15;
            }
          }
        }
        if (player.actions.movement.left === true) {
          if (_this.players[0].bitmap.currentAnimation === "standd") {
            _this.players[0].bitmap.gotoAndPlay("runr_h");
          }
          if ((_this.world.x + 15) > 0) {
            _this.players[0].bitmap.x -= 15;
          } else if (game.players[0].bitmap.x !== window.innerWidth / 2) {
            _this.players[0].bitmap.x -= 15;
          } else {
            if (!collision.checkPixelCollision(_this.players[0].bitmap, _this.players[1].bitmap, 0, true)) {
              _this.world.x += 15;
            }
          }
        }
        if (player.actions.movement.right === true) {
          if (_this.players[0].bitmap.currentAnimation === "standd") {
            _this.players[0].bitmap.gotoAndPlay("runr");
          }
          if ((_this.world.x - 15) < (-40000 + window.innerWidth)) {
            _this.players[0].bitmap.x += 15;
          } else if (game.players[0].bitmap.x !== window.innerWidth / 2) {
            _this.players[0].bitmap.x += 15;
          } else {
            if (!collision.checkPixelCollision(_this.players[0].bitmap, _this.players[1].bitmap, 0, true)) {
              _this.world.x -= 15;
            }
          }
        }
      }
      return _this.stage.update();
    });
    document.oncontextmenu = function(e) {
      e.preventDefault();
      return createjs.Sound.play("/audio/reload.mp3");
    };
    document.onmousedown = function(e) {
      switch (e.which) {
        case 1:
          _this.shootInstance = createjs.Sound.play("audio/smg.m4a", "none", 0, 0, -1);
          return _this.players[0].actions.weapons.shooting.automatic = true;
      }
    };
    document.onmouseup = function(e) {
      switch (e.which) {
        case 1:
          _this.shootInstance.stop("audio/smg.m4a", "none", 0, 0, 0);
          return _this.players[0].actions.weapons.shooting.automatic = false;
      }
    };
    document.onkeydown = function(e) {
      switch (e.which) {
        case 87:
          return _this.players[0].actions.movement.up = true;
        case 83:
          return _this.players[0].actions.movement.down = true;
        case 65:
          return _this.players[0].actions.movement.left = true;
        case 68:
          return _this.players[0].actions.movement.right = true;
      }
    };
    document.onkeyup = function(e) {
      switch (e.which) {
        case 87:
          _this.players[0].actions.movement.up = false;
          return _this.players[0].bitmap.gotoAndPlay("standd");
        case 83:
          _this.players[0].actions.movement.down = false;
          return _this.players[0].bitmap.gotoAndPlay("standd");
        case 65:
          _this.players[0].actions.movement.left = false;
          return _this.players[0].bitmap.gotoAndPlay("standd");
        case 68:
          _this.players[0].actions.movement.right = false;
          return _this.players[0].bitmap.gotoAndPlay("standd");
      }
    };
  }

  return Game;

})();

if (typeof window !== "undefined" && window !== null) {
  window.Game = Game;
} else if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
  module.exports = Game;
}