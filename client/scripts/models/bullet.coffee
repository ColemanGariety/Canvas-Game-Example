class window.Bullet extends Player
  constructor: (player) ->
    @player = player || game.players[0]
    
    @px = -game.world.x + game.players[0].bitmap.x
    @py = -game.world.y + game.players[0].bitmap.y
    @mx = -game.world.x + game.posx
    @my = -game.world.y + game.posy
    
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
          console.log "#{bullet.player.name} shot #{enemy.name}"
          
          # Impact sound
          createjs.Sound.play "audio/impact.mp3"
          
          if enemy.health >= 1
            enemy.health -= 5
          else
            game.world.removeChild enemy.bitmap
            game.enemies.splice(game.enemies.indexOf(enemy), 1)

          game.bullets.splice(game.bullets.indexOf(bullet), 1)
          game.world.removeChild bullet.shape

      bullet.shape.x += Math.sin(bullet.direction) * 100
      bullet.shape.y += Math.cos(bullet.direction) * 100
    else if bullet
      game.world.removeChild bullet.shape
      game.bullets.splice(game.bullets.indexOf(bullet), 1)