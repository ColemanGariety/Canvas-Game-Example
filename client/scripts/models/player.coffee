class window.Player extends Game
  constructor: (name, isPuppet) ->
    @name = name || "Anon"

    console.log "#{@name} has joined the struggle"

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
          frequency: 20
        standu:
          frames: [4, 5]
          frequency: 20
        runu:
          frames: [8, 9, 10, 11]
          frequency: 6
        rund:
          frames: [12, 13, 14, 9]
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
      game.players[0].bulletInterval = setInterval ->
        bullet = new Bullet()
      , 60
    else if command == "stop"
      clearInterval(game.players[0].bulletInterval)

  @move = ->
    # Move up
    if game.players[0].actions.indexOf("runUp") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runu")

      if (game.world.y + 9) > 0
        game.players[0].bitmap.y -= 9
      else if game.players[0].bitmap.y != window.innerHeight / 2
        game.players[0].bitmap.y -= 9
      else
        game.world.y += 9
    
    # Move down
    if game.players[0].actions.indexOf("runDown") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("rund")

      if (game.world.y - 9) < (-40000 + window.innerWidth)
        game.players[0].bitmap.y += 9
      else if game.players[0].bitmap.y != window.innerHeight / 2
        game.players[0].bitmap.y += 9
      else
        game.world.y -= 9
    
    # Move left
    if game.players[0].actions.indexOf("runLeft") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runr_h")

      if (game.world.x + 9) > 0
        game.players[0].bitmap.x -= 9
      else if game.players[0].bitmap.x != window.innerWidth / 2
        game.players[0].bitmap.x -= 9
      else
        game.world.x += 9
    
    # Move right
    if game.players[0].actions.indexOf("runRight") != -1
      if game.players[0].bitmap.currentAnimation == "standd"
        game.players[0].bitmap.gotoAndPlay("runr")

      if (game.world.x - 9) < (-40000 + window.innerWidth)
        game.players[0].bitmap.x += 9
      else if game.players[0].bitmap.x != window.innerWidth / 2
        game.players[0].bitmap.x += 9
      else
        game.world.x -= 9
