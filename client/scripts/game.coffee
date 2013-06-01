# Wait for resources to load
class Game
  constructor: (canvasId) ->
    # Start the game
    @stage = new createjs.Stage canvasId
    console.log "Started the game."

    # Initialize the world
    @world = new createjs.Container()
    @stage.addChild(@world)
    
    # Game music
    handleLoad = (event) ->
      instance = createjs.Sound.play("ragevalley")
      instance.setVolume(0.25);
    createjs.Sound.addEventListener("fileload", handleLoad)
    # createjs.Sound.registerSound("audio/rage.mp3", "ragevalley")

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
      # Move up
      if @players[0].actions.indexOf("runUp") != -1
        if @players[0].bitmap.currentAnimation == "standd"
          @players[0].bitmap.gotoAndPlay("runu")

        if (@world.y + 15) > 0
          @players[0].bitmap.y -= 15
        else if game.players[0].bitmap.y != window.innerHeight / 2
          @players[0].bitmap.y -= 15
        else
          @world.y += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
      
      # Move down
      if @players[0].actions.indexOf("runDown") != -1
        if @players[0].bitmap.currentAnimation == "standd"
          @players[0].bitmap.gotoAndPlay("rund")

        if (@world.y - 15) < (-40000 + window.innerWidth)
          @players[0].bitmap.y += 15
        else if game.players[0].bitmap.y != window.innerHeight / 2
          @players[0].bitmap.y += 15
        else
          @world.y -= 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
      
      # Move left
      if @players[0].actions.indexOf("runLeft") != -1
        if @players[0].bitmap.currentAnimation == "standd"
          @players[0].bitmap.gotoAndPlay("runr_h")

        if (@world.x + 15) > 0
          @players[0].bitmap.x -= 15
        else if game.players[0].bitmap.x != window.innerWidth / 2
          @players[0].bitmap.x -= 15
        else
          @world.x += 15 unless collision.checkPixelCollision(@players[0].bitmap, @players[1].bitmap, 0, true)
      
      # Move right
      if @players[0].actions.indexOf("runRight") != -1
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
        when 1 then @shootInstance = createjs.Sound.play("audio/smg.m4a", "none", 0, 0, -1); @players[0].actions.push("shoot");

    document.onmouseup = (e) =>
      switch e.which
        when 1 then  @shootInstance.stop("audio/smg.m4a", "none", 0, 0, 0); @players[0].actions.splice(@players[0].actions.indexOf("shoot"), 1);

    # Movement controls
    document.onkeydown = (e) =>
      switch e.which
        when 87 then @players[0].actions.push("runUp") unless @players[0].actions.indexOf("runUp") != -1
        when 83 then @players[0].actions.push("runDown") unless @players[0].actions.indexOf("runDown") != -1
        when 65 then @players[0].actions.push("runLeft") unless @players[0].actions.indexOf("runLeft") != -1
        when 68 then @players[0].actions.push("runRight") unless @players[0].actions.indexOf("runRight") != -1

    document.onkeyup = (e) =>
      switch e.which
        when 87 then @players[0].actions.splice(@players[0].actions.indexOf("runUp"), 1); @players[0].bitmap.gotoAndPlay("standd")
        when 83 then @players[0].actions.splice(@players[0].actions.indexOf("runDown"), 1); @players[0].bitmap.gotoAndPlay("standd")
        when 65 then @players[0].actions.splice(@players[0].actions.indexOf("runLeft"), 1); @players[0].bitmap.gotoAndPlay("standd")
        when 68 then @players[0].actions.splice(@players[0].actions.indexOf("runRight"), 1); @players[0].bitmap.gotoAndPlay("standd")

# ?
if window? then window.Game = Game else if module?.exports? then module.exports = Game