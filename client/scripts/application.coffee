# Wait for resources to load
document.body.onload = ->
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
        retina = window.devicePixelRatio > 1 ? true : false;
        if retina
          @stage.canvas.width = window.innerWidth * 2;
          @stage.canvas.height = window.innerHeight * 2;
        else
          @stage.canvas.width = window.innerWidth;
          @stage.canvas.height = window.innerHeight;

        @stage.canvas.style.width = "#{window.innerWidth}px"
        @stage.canvas.style.height = "#{window.innerHeight}px"

        # Move the world
          # I failed math

        # Move the player
        if @players[0]
          @players[0].bitmap.x = window.innerWidth / 2
          @players[0].bitmap.y = window.innerHeight / 2

        # Redraw
        @stage.update()

      # Resize triggers
      resizeCanvas()
      window.addEventListener 'resize', resizeCanvas

      # Render loop
      createjs.Ticker.setFPS 30
      createjs.Ticker.addEventListener "tick", =>
        for player in @players

          # Movement actions
          if player.actions.movement.up == true
            @world.y += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
          if player.actions.movement.down == true
            @world.y -= 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
          if player.actions.movement.left == true
            @world.x += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
          if player.actions.movement.right == true
            @world.x -= 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)

        # Redraw
        @stage.update()

      # Weapon controls
      document.oncontextmenu = (e) =>
        e.preventDefault()
        createjs.Sound.play "/audio/reload.mp3"

      # Movement controls
      document.onkeydown = (e) =>
        switch e.which
          when 87 then @players[0].actions.movement.up = true
          when 83 then @players[0].actions.movement.down = true
          when 65 then @players[0].actions.movement.left = true
          when 68 then @players[0].actions.movement.right = true

      document.onkeyup = (e) =>
        switch e.which
          when 87 then @players[0].actions.movement.up = false
          when 83 then @players[0].actions.movement.down = false
          when 65 then @players[0].actions.movement.left = false
          when 68 then @players[0].actions.movement.right = false

  class Player extends Game
    constructor: (name, isPuppet) ->
      @name = name || "Anon"

      console.log "#{@name} has joined."

      @isPuppet = isPuppet || false

      @spritesheet = new createjs.SpriteSheet(
        images: ["images/player.png"]
        frames:
          width: 100
          height: 106
        animations:
          stand: [0]
          run:
            frames: [0, 1]
            frequency: 2
      )

      @bitmap = new createjs.BitmapAnimation(@spritesheet)

      if isPuppet
        @bitmap.x = window.innerWidth / 2
        @bitmap.y = window.innerHeight / 2
      else
        @bitmap.x = window.innerWidth / 2 + 100
        @bitmap.y = window.innerHeight / 2 + 100

      @bitmap.gotoAndPlay("stand")

      @actions =
        movement:
          up: false
          down: false
          left: false
          right: false

      if isPuppet
        game.stage.addChild @bitmap
      else
        game.world.addChild @bitmap

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

  # Adds some stuff to mess around with
  new Continent()
  new Player("Jackson", true)
  new Player("Elliot", false)

  # ?
  if window? then window.Game = Game else if module?.exports? then module.exports = Game