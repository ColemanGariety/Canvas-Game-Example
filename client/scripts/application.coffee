# Start the game
class Game
  constructor: (canvasId) ->
    @stage = new createjs.Stage canvasId
    @players = []

    console.log "Started the game."

    # Size the canvas
    resizeCanvas = =>
      @stage.canvas.width = window.innerWidth
      @stage.canvas.height = window.innerHeight
      @stage.update()
    resizeCanvas()
    window.addEventListener 'resize', resizeCanvas

    # Render loop
    createjs.Ticker.setFPS 30
    createjs.Ticker.addEventListener "tick", =>
      for player in @players
        if player.actions.movement.up == true
          player.bitmap.y -= 15
        if player.actions.movement.down == true
          player.bitmap.y += 15
        if player.actions.movement.left == true
          player.bitmap.x -= 15
        if player.actions.movement.right == true
          player.bitmap.x += 15

      @stage.update()

    # Controls
    document.onkeydown = (e) =>
      switch e.which
        when 87 then game.players[0].actions.movement.up = true
        when 83 then game.players[0].actions.movement.down = true
        when 65 then game.players[0].actions.movement.left = true
        when 68 then game.players[0].actions.movement.right = true

    document.onkeyup = (e) =>
      switch e.which
        when 87 then game.players[0].actions.movement.up = false
        when 83 then game.players[0].actions.movement.down = false
        when 65 then game.players[0].actions.movement.left = false
        when 68 then game.players[0].actions.movement.right = false

class Player extends Game
  constructor: (name) ->
    console.log "#{name} has joined."

    @name = name || "Anon"

    @bitmap = new createjs.Shape()
    @bitmap.graphics.beginFill("red").drawCircle(0, 0, 50)
    @bitmap.x = 50
    @bitmap.y = 50

    @actions =
      movement:
        up: false
        down: false
        left: false
        right: false

    game.stage.addChild @bitmap
    game.players.push(@)

# Start the game
game = new Game("gameCanvas");

# Adds the puppet
new Player("Jackson", true)

# ?
if window? then window.Game = Game else if module?.exports? then module.exports = Game