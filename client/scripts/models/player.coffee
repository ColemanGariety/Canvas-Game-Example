class window.Player extends Game
  constructor: (name, isPuppet) ->
    @name = name || "Anon"
    
    @level = 1
    
    @ammo =
      machinegun: 100
      pistol: 30
      shotgun: 10
      cannon: 1
      grenade: 2
    
    @cartridges =
      machinegun: 5
      pistol: 0
      shotgun: 0
      cannon: 0
      grenade: 0

    console.log "#{@name} has joined the struggle"

    @isPuppet = isPuppet || false

    @spritesheet = new createjs.SpriteSheet(
      images: ["images/player.png"]
      frames: [
        [0, 128, 128, 128, 0, 64, 64],
        [128, 128, 128, 128, 0, 64, 64],
        [256, 128, 128, 128, 0, 64, 64],
        [384, 128, 128, 128, 0, 64, 64],
        [0, 640, 128, 128, 0, 64, 64],
        [128, 640, 128, 128, 0, 64, 64],
        [0, 1024, 128, 128, 0, 64, 64],
        [128, 1024, 128, 128, 0, 64, 64],
        [0, 512, 128, 128, 0, 64, 64],
        [128, 512, 128, 128, 0, 64, 64],
        [256, 512, 128, 128, 0, 64, 64],
        [384, 512, 128, 128, 0, 64, 64],
        [0, 896, 128, 128, 0, 64, 64],
        [128, 896, 128, 128, 0, 64, 64],
        [256, 896, 128, 128, 0, 64, 64],
        [384, 896, 128, 128, 0, 64, 64]
      ]
      animations:
        standd:
          frames: [6, 7]
          frequency: 20
        standu:
          frames: [4, 5]
          frequency: 20
        runu:
          frames: [8, 9, 10, 11]
          frequency: 6
        rund:
          frames: [12, 13, 14, 15]
          frequency: 6
        runr:
          frames: [0, 1, 2, 3]
          frequency: 6
    )

    createjs.SpriteSheetUtils.addFlippedFrames(@spritesheet, true)

    @bitmap = new createjs.BitmapAnimation(@spritesheet)

    if isPuppet
      @bitmap.x = window.innerWidth / 2
      @bitmap.y = window.innerHeight / 2
    else
      @bitmap.x = window.innerWidth / 2 + (Math.random() * (300 * 2) - 300)
      @bitmap.y = window.innerHeight / 2 + (Math.random() * (300 * 2) - 300)

    @bitmap.gotoAndPlay("standd")

    @actions = []

    if isPuppet
      game.stage.addChild @bitmap
    else
      game.world.addChild @bitmap

    game.players.push(@)
  
  @shoot = (command, type) ->
    if command == "start"
      if game.players[0].ammo.machinegun
        game.players[0].bulletInterval = setInterval ->
          if game.players[0].ammo.machinegun
            bullet = new Bullet(game.players[0], "machinegun")
          else
            clearInterval(game.players[0].bulletInterval)
            createjs.Sound.play "audio/dry.m4a"
        , 100
      else
        createjs.Sound.play "audio/dry.m4a"
    else if command == "stop"
      clearInterval(game.players[0].bulletInterval)

  @move = ->
    # Move up
    if game.players[0].actions.indexOf("runUp") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runu")

      if (game.world.y + 7) > 0
        game.players[0].bitmap.y -= 7
      else if game.players[0].bitmap.y != window.innerHeight / 2
        game.players[0].bitmap.y -= 7
      else
        game.world.y += 7
    
    # Move down
    if game.players[0].actions.indexOf("runDown") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("rund")

      if (game.world.y - 7) < (-40000 + window.innerWidth)
        game.players[0].bitmap.y += 7
      else if game.players[0].bitmap.y != window.innerHeight / 2
        game.players[0].bitmap.y += 7
      else
        game.world.y -= 7
    
    # Move left
    if game.players[0].actions.indexOf("runLeft") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runr_h")

      if (game.world.x + 7) > 0
        game.players[0].bitmap.x -= 7
      else if game.players[0].bitmap.x != window.innerWidth / 2
        game.players[0].bitmap.x -= 7
      else
        game.world.x += 7
    
    # Move right
    if game.players[0].actions.indexOf("runRight") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runr")

      if (game.world.x - 7) < (-40000 + window.innerWidth)
        game.players[0].bitmap.x += 7
      else if game.players[0].bitmap.x != window.innerWidth / 2
        game.players[0].bitmap.x += 7
      else
        game.world.x -= 7

    for drop in game.drops
      if collision.checkRectCollision(game.players[0].bitmap, drop.shape, 0, true)
        Drop.pickup(game.players[0], drop)