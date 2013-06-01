# Wait for resources to load
class Game
  constructor: (canvasId) ->
    # Start the game
    @stage = new createjs.Stage canvasId
    console.log "Started the game."

    # Initialize the world
    @world = new createjs.Container()
    @stage.addChild(@world)
    
    # Start music
    handleLoad = (event) ->
      # instance = instance = createjs.Sound.play("ragevalley")
      instance.setVolume(0.25);
    createjs.Sound.addEventListener("fileload", handleLoad)
    createjs.Sound.registerSound("audio/rage.mp3", "ragevalley")

    # Players in the game
    @players = []

    # Size the canvas
    resizeCanvas = =>
      @stage.canvas.width = window.innerWidth;
      @stage.canvas.height = window.innerHeight;

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
          if @players[0].bitmap.currentAnimation == "standd"
            @players[0].bitmap.gotoAndPlay("runu")

          if (@world.y + 15) > 0
            @players[0].bitmap.y -= 15
          else if game.players[0].bitmap.y != window.innerHeight / 2
            @players[0].bitmap.y -= 15
          else
            @world.y += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
        if player.actions.movement.down == true
          if @players[0].bitmap.currentAnimation == "standd"
            @players[0].bitmap.gotoAndPlay("rund")

          if (@world.y - 15) < (-40000 + window.innerWidth)
            @players[0].bitmap.y += 15
          else if game.players[0].bitmap.y != window.innerHeight / 2
            @players[0].bitmap.y += 15
          else
            @world.y -= 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
        if player.actions.movement.left == true
          if @players[0].bitmap.currentAnimation == "standd"
            @players[0].bitmap.gotoAndPlay("runr_h")

          if (@world.x + 15) > 0
            @players[0].bitmap.x -= 15
          else if game.players[0].bitmap.x != window.innerWidth / 2
            @players[0].bitmap.x -= 15
          else
            @world.x += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
        if player.actions.movement.right == true
          if @players[0].bitmap.currentAnimation == "standd"
            @players[0].bitmap.gotoAndPlay("runr")

          if (@world.x - 15) < (-40000 + window.innerWidth)
            @players[0].bitmap.x += 15
          else if game.players[0].bitmap.x != window.innerWidth / 2
            @players[0].bitmap.x += 15
          else
            @world.x -= 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)

      # Redraw
      @stage.update()

    # Weapon controls
    document.oncontextmenu = (e) =>
      e.preventDefault()
      createjs.Sound.play "/audio/reload.mp3"

    document.onmousedown = (e) =>
      switch e.which
        when 1 then @shootInstance = createjs.Sound.play("audio/smg.m4a", "none", 0, 0, -1); @players[0].actions.weapons.shooting.automatic = true;

    document.onmouseup = (e) =>
      switch e.which
        when 1 then  @shootInstance.stop("audio/smg.m4a", "none", 0, 0, 0); @players[0].actions.weapons.shooting.automatic = false;

    # Movement controls
    document.onkeydown = (e) =>
      switch e.which
        when 87 then @players[0].actions.movement.up = true
        when 83 then @players[0].actions.movement.down = true
        when 65 then @players[0].actions.movement.left = true
        when 68 then @players[0].actions.movement.right = true

    document.onkeyup = (e) =>
      switch e.which
        when 87 then @players[0].actions.movement.up = false; @players[0].bitmap.gotoAndPlay("standd")
        when 83 then @players[0].actions.movement.down = false; @players[0].bitmap.gotoAndPlay("standd")
        when 65 then @players[0].actions.movement.left = false; @players[0].bitmap.gotoAndPlay("standd")
        when 68 then @players[0].actions.movement.right = false; @players[0].bitmap.gotoAndPlay("standd")

class Player extends Game
  constructor: (name, isPuppet) ->
    @name = name || "Anon"

    console.log "#{@name} has joined."

    @isPuppet = isPuppet || false

    @spritesheet = new createjs.SpriteSheet(
      images: ["images/player.png"]
      frames: [
        [0, 111, 111, 111, 0, 55, 55],
        [111, 111, 111, 111, 0, 55, 55],
        [222, 111, 111, 111, 0, 55, 55],
        [333, 111, 111, 111, 0, 55, 55],
        [0, 555, 111, 111, 0, 55, 55],
        [111, 555, 111, 111, 0, 55, 55],
        [0, 888, 111, 111, 0, 55, 55],
        [111, 888, 111, 111, 0, 55, 55],
        [0, 444, 111, 111, 0, 55, 55],
        [111, 444, 111, 111, 0, 55, 55],
        [222, 444, 111, 111, 0, 55, 55],
        [333, 444, 111, 111, 0, 55, 55],
        [0, 777, 111, 111, 0, 55, 55],
        [111, 777, 111, 111, 0, 55, 55],
        [222, 777, 111, 111, 0, 55, 55],
        [333, 777, 111, 111, 0, 55, 55]
      ]
      animations:
        standd:
          frames: [6, 7]
          frequency: 10
        standu:
          frames: [4, 5]
          frequency: 10
        runu:
          frames: [8, 9, 10, 11]
          frequency: 3
        rund:
          frames: [12, 13, 14, 15]
          frequency: 3
        runr:
          frames: [0, 1, 2, 3]
          frequency: 3
    )

    createjs.SpriteSheetUtils.addFlippedFrames(@spritesheet, true)

    @bitmap = new createjs.BitmapAnimation(@spritesheet)

    if isPuppet
      @bitmap.x = window.innerWidth / 2
      @bitmap.y = window.innerHeight / 2
    else
      @bitmap.x = window.innerWidth / 2 + 100
      @bitmap.y = window.innerHeight / 2 + 100

    @bitmap.regX = 50
    @bitmap.regY = 53

    @bitmap.gotoAndPlay("standd")

    @actions =
      movement:
        up: false
        down: false
        left: false
        right: false
      weapons:
        shooting:
          automatic: false
          manual: false

    if isPuppet
      game.stage.addChild @bitmap
    else
      game.world.addChild @bitmap

    game.players.push(@)

class Continent extends Game
  constructor: (name) ->
    @name = name || "Homeland"

    @x = 0
    @y = 0

    @bitmap = new Image()
    @bitmap.src = "images/grass.jpg"

    @shape = new createjs.Shape()
    @shape.graphics.beginBitmapFill(@bitmap, "repeat").drawRect(0, 0, 40000, 40000)

    game.world.addChild(@shape);

# Start the game
game = new Game("gameCanvas")

# Adds some stuff to mess around with
new Continent()
new Player("Jackson", true)
new Player("Elliot", false)

# ?
if window? then window.Game = Game else if module?.exports? then module.exports = Game