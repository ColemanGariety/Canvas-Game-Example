class window.Player extends Game
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

    @actions = []

    if isPuppet
      game.stage.addChild @bitmap
    else
      game.world.addChild @bitmap

    game.players.push(@)
