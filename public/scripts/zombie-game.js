;(function(e,t,n){function i(n,s){if(!t[n]){if(!e[n]){var o=typeof require=="function"&&require;if(!s&&o)return o(n,!0);if(r)return r(n,!0);throw new Error("Cannot find module '"+n+"'")}var u=t[n]={exports:{}};e[n][0].call(u.exports,function(t){var r=e[n][1][t];return i(r?r:t)},u,u.exports)}return t[n].exports}var r=typeof require=="function"&&require;for(var s=0;s<n.length;s++)i(n[s]);return i})({1:[function(require,module,exports){
// Generated by CoffeeScript 1.6.2
(function() {
  var ZombieGame;

  ZombieGame = (function() {
    function ZombieGame(p_canvasId) {
      var circle;

      this.stage = new createjs.Stage(p_canvasId);
      this.startRenderLoop();
      circle = new createjs.Shape();
      circle.graphics.beginFill("red").drawCircle(0, 0, 50);
      circle.x = 100;
      circle.y = 100;
      this.stage.addChild(circle);
      this.stage.update();
    }

    ZombieGame.prototype.startRenderLoop = function() {};

    return ZombieGame;

  })();

  window.ZombieGame = ZombieGame;

}).call(this);

},{}]},{},[1])
;