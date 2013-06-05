class window.Bullet extends Player
  constructor: (player) ->
    @player = player || game.players[0]
    
    @player.ammo.machinegun--
    Hud.update("ammo")
    
    @shootInstance = createjs.Sound.play("audio/smg.m4a", "none", 0, 0, 0)
    
    @px = -game.world.x + game.players[0].bitmap.x
    @py = -game.world.y + game.players[0].bitmap.y
    @mx = -game.world.x + game.mouseX
    @my = -game.world.y + game.mouseY
    
    @accuracy = .05
    
    @direction = Math.atan2(@mx - @px, @my - @py) + (Math.random() * (@accuracy * 2) - @accuracy)
    
    @shape = new createjs.Shape()
    @shape.rotation = -(@direction * (180 / Math.PI) + 90)
    @shape.alpha = .75
    @shape.graphics.beginFill("#FFFF00").drawRect(0, 0, 125, 2)
    
    @shape.regx = 100
    @shape.regy = 1
    
    @shape.x = -game.world.x + game.players[0].bitmap.x
    @shape.y = -game.world.y + game.players[0].bitmap.y
    
    # Add bullets to the game
    game.world.addChild @shape
    game.bullets.push(@)
  
  @move = (bullet) ->
  
    unless !bullet || bullet.shape.x > (window.innerWidth - game.world.x) || bullet.shape.x < -game.world.x || bullet.shape.y > (window.innerHeight - game.world.y) || bullet.shape.y < -game.world.y
      for enemy in game.enemies
        if enemy && collision.checkRectCollision(bullet.shape, enemy.bitmap, 0, true)
          
          # Slow down
          enemy.bitmap.x += Math.sin(bullet.direction) * 4
          enemy.bitmap.y += Math.cos(bullet.direction) * 4
          enemy.pause()
          
          # Impact sound
          impactInstance = createjs.Sound.play "audio/impact.m4a"
          impactInstance.setVolume .25
          
          if enemy.health >= 1
            enemy.health -= 10
          else
            console.log "#{bullet.player.name} killed #{enemy.name}"
            game.world.removeChild enemy.bitmap
            game.enemies.splice(game.enemies.indexOf(enemy), 1)
            new Drop(enemy)

          game.bullets.splice(game.bullets.indexOf(bullet), 1)
          game.world.removeChild bullet.shape

      bullet.shape.x += Math.sin(bullet.direction) * 100
      bullet.shape.y += Math.cos(bullet.direction) * 100
    else if bullet
      game.world.removeChild bullet.shape
      game.bullets.splice(game.bullets.indexOf(bullet), 1)