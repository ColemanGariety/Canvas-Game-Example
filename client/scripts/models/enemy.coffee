class window.Enemy extends Game
  @spritesheet = new createjs.SpriteSheet(
    images: ["images/corpse.png"]
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
        frequency: 75
      standu:
        frames: [4, 5]
        frequency: 75
      runu:
        frames: [8, 9, 10, 11]
        frequency: 50
      rund:
        frames: [12, 13, 14, 15]
        frequency: 50
      runr:
        frames: [0, 1, 2, 3]
        frequency: 50
  )

  createjs.SpriteSheetUtils.addFlippedFrames(Enemy.spritesheet, true)

  constructor: (name, health, type, walker) ->
    if name
      @name = "#{name}'s Corpse"
    else
      @name = "A Corpse"
    
    @pause = =>
      @walker = false
      # @bitmap.gotoAndPlay("standd")
      setTimeout =>
        @walker = true
      , 2000

    @destroy = =>
      game.world.removeChild @bitmap
      game.enemies.remove(@)

    @walker = true
    
    @hurt = (bullet) =>
      # Slow down
      @bitmap.x += Math.sin(bullet.direction) * 4
      @bitmap.y += Math.cos(bullet.direction) * 4
      @pause()
      
      # Impact sound
      impactInstance = createjs.Sound.play "audio/impact.m4a"
      impactInstance.setVolume .25
      
      if @health >= 1
        @health -= 10
      else
        @.kill(bullet)
      
    @kill = (bullet) =>
      console.log "#{bullet.player.name} killed #{@.name}"
      game.world.removeChild @.bitmap
      game.enemies.remove(@)
      new Drop(@)
    
    @health = health || 100
    @type = type || "corpse"
    
    console.log "#{@name} gets up and moves"

    @bitmap = new createjs.BitmapAnimation(Enemy.spritesheet)

    @bitmap.x = Math.floor(Math.random() * (4000 - 0 + 1)) + 0
    @bitmap.y = Math.floor(Math.random() * (4000 - 0 + 1)) + 0

    @bitmap.gotoAndPlay("standd")

    @actions = []

    game.world.addChild @bitmap
    game.enemies.push(@)
    
  @move = (enemy) ->
  
    if enemy.walker == true
      px = -game.world.x + game.players[0].bitmap.x
      py = -game.world.y + game.players[0].bitmap.y
      ex = enemy.bitmap.x
      ey = enemy.bitmap.y
      
      enemy.direction = Math.atan2(px - ex, py - ey)
  
      x = Math.sin(enemy.direction) / 2
      y = Math.cos(enemy.direction) / 2
  
      enemy.bitmap.x += x
      enemy.bitmap.y += y
      

      if enemy.direction > 2.5 || enemy.direction < -2.5
        enemy.bitmap.gotoAndPlay("runu") unless enemy.bitmap.currentAnimation == "runu"
      else if enemy.direction > .75
        enemy.bitmap.gotoAndPlay("runr") unless enemy.bitmap.currentAnimation == "runr"
      else if enemy.direction > -.75
        enemy.bitmap.gotoAndPlay("rund") unless enemy.bitmap.currentAnimation == "rund"
      else
        enemy.bitmap.gotoAndPlay("runr_h") unless enemy.bitmap.currentAnimation == "runr_h"