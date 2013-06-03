class window.Enemy extends Game
  constructor: (name, health, type) ->
    if name
      @name = "#{name}'s Corpse"
    else
      @name = "A Buried Corpse"
    
    @health = health || 100
    @type = type || "corpse"
    
    console.log "#{@name} gets up and moves"
    
    @spritesheet = new createjs.SpriteSheet(
      images: ["images/corpse.png"]
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
          frames: [12, 13, 14, 15]
          frequency: 6
        runr:
          frames: [0, 1, 2, 3]
          frequency: 6
    )

    createjs.SpriteSheetUtils.addFlippedFrames(@spritesheet, true)

    @bitmap = new createjs.BitmapAnimation(@spritesheet)

    @bitmap.x = window.innerWidth / 2 + (Math.random() * (300 * 2) - 300)
    @bitmap.y = window.innerHeight / 2 + (Math.random() * (300 * 2) - 300)

    @bitmap.gotoAndPlay("standd")

    @actions = []

    game.world.addChild @bitmap
    game.enemies.push(@)
    
  @move = (enemy) ->
    px = -game.world.x + game.players[0].bitmap.x
    py = -game.world.y + game.players[0].bitmap.y
    ex = enemy.bitmap.x
    ey = enemy.bitmap.y
    
    direction = Math.atan2(px - ex, py - ey)

    enemy.bitmap.x += Math.sin(direction) / 2
    enemy.bitmap.y += Math.cos(direction) / 2