class Game
  constructor: (canvasId) ->
    # Start the game
    @stage = new createjs.Stage canvasId
    console.log "Started the game."

    # Initialize the world
    @world = new createjs.Container()
    @stage.addChild(@world)

    # Players in the game
    @players = []

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

        # Movement actions
        if player.actions.movement.up == true
          @world.y += 15
        if player.actions.movement.down == true
          @world.y -= 15
        if player.actions.movement.left == true
          @world.x += 15
        if player.actions.movement.right == true
          @world.x -= 15

      # Redraw
      @stage.update()

    # Weapon controls
    document.oncontextmenu = (e) =>
      e.preventDefault()

    # Movement controls
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
  constructor: (name, isPuppet) ->
    @name = name || "Anon"

    console.log "#{@name} has joined."

    @isPuppet = isPuppet || false

    @shape = new createjs.Shape()
    @shape.graphics.beginFill("red").drawCircle(0, 0, 50)
    @shape.x = window.innerWidth / 2
    @shape.y = window.innerHeight / 2
    @shape.regX = 50
    @shape.regY = 50

    @actions =
      movement:
        up: false
        down: false
        left: false
        right: false

    if isPuppet
      game.stage.addChild @shape
    else
      game.world.addChild @shape

    game.players.push(@)

class Continent extends Game
  constructor: (name) ->
    @name = name || "Homeland"

    @bitmap = new Image()
    @bitmap.src = "images/grass.jpg"

    @shape = new createjs.Shape()
    @shape.graphics.beginBitmapFill(@bitmap, "repeat").drawRect(0, 0, 4000, 4000)

    game.world.addChild(@shape);

# Start the game
game = new Game("gameCanvas")

# Adds the puppet
new Continent()
new Player("Jackson", true)
new Player("Elliot", false)

# ?
if window? then window.Game = Game else if module?.exports? then module.exports = Game