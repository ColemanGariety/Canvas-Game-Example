# Wait for resources to load
class window.Game
  constructor: (canvasId) ->
    # Start the game
    @stage = new createjs.Stage canvasId
    console.log "Started the game"

    # Initialize the world
    @world = new createjs.Container()
    @stage.addChild(@world)
    
    # Game music
    handleLoad = (e) ->
      instance = createjs.Sound.play "ragevalley"
      instance.setVolume 0.25
    createjs.Sound.addEventListener("fileload", handleLoad)
    createjs.Sound.registerSound("music/sleaze.m4a", "ragevalley")

    # Players & bullets in the game
    @players = []
    @bullets = []
    @enemies = []
    @drops   = []

    # Render loop
    createjs.Ticker.setFPS 60
    createjs.Ticker.addEventListener "tick", =>
      Player.move()
      
      for bullet in @bullets
        Bullet.move bullet
      
      for enemy in @enemies
        Enemy.move enemy
    
      # Redraw
      @stage.update()

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

    # User input
    document.onmousemove = (e) =>
      @mouseX = e.clientX
      @mouseY = e.clientY
    
    document.oncontextmenu = (e) =>
      e.preventDefault()
      createjs.Sound.play "/audio/reload.m4a"
      unless @players[0].ammo.machinegun == 100 || !@players[0].cartridges.machinegun
        @players[0].ammo.machinegun = 100 
        @players[0].cartridges.machinegun--
      
      Hud.update("ammo")

    document.onmousedown = (e) =>
      switch e.which
        when 1
          
          Player.shoot("start") if @players[0].actions.indexOf("shoot") == -1
          @players[0].actions.push("shoot")

    document.onmouseup = (e) =>
      switch e.which
        when 1
          Player.shoot("stop")
          @players[0].actions.splice(@players[0].actions.indexOf("shoot"), 1)

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