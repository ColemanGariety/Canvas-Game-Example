class window.Bullet extends Player
  constructor: (player, type) ->
    @player = player || game.players[0]
    
    @type = type || "machinegun"

    @px = -game.world.x + game.players[0].bitmap.x
    @py = -game.world.y + game.players[0].bitmap.y
    @mx = -game.world.x + game.mouseX
    @my = -game.world.y + game.mouseY
    
    @destroy = =>
      game.world.removeChild @shape
      game.bullets.remove(@)
    
    @direction = Math.atan2(@mx - @px, @my - @py)

    switch @type
      when "machinegun"
        @player.ammo.machinegun--
        Hud.update("ammo")
        
        @accuracy = .066
        
        @direction += (Math.random() * (@accuracy * 2) - @accuracy)
    
        @shootInstance = createjs.Sound.play("audio/smg.m4a", "none", 0, 0, 0)
    
        @shape = new createjs.Shape()
        @shape.rotation = -(@direction * (180 / Math.PI) + 90)
        @shape.alpha = .75
        @shape.graphics.beginFill("#FFFF00").drawRect(0, 0, 125, 2)
        @shape.regx = 100
        @shape.regy = 1
        
      when "grenade"
        @shape = new createjs.Shape()
        @shape.graphics.beginFill("#000").drawCircle(0, 0, 10, 2)
        @shape.regx = 100
        @shape.regy = 1

    @shape.x = -game.world.x + game.players[0].bitmap.x
    @shape.y = -game.world.y + game.players[0].bitmap.y    
    
    # Add bullets to the game
    game.world.addChild @shape
    game.bullets.push(@)
  
  @move = (bullet) ->
    if bullet
      switch bullet.type
        when "machinegun"
          unless !bullet || bullet.shape.x > (window.innerWidth - game.world.x) || bullet.shape.x < -game.world.x || bullet.shape.y > (window.innerHeight - game.world.y) || bullet.shape.y < -game.world.y
            for enemy in game.enemies
              if enemy && collision.checkRectCollision(bullet.shape, enemy.bitmap, 0, true)
                enemy.hurt(bullet)
                bullet.destroy()
      
            bullet.shape.x += Math.sin(bullet.direction) * 100
            bullet.shape.y += Math.cos(bullet.direction) * 100
          else if bullet
            game.world.removeChild bullet.shape
            game.bullets.remove(bullet)
        when "grenade"
          unless !bullet || bullet.exploded
            bullet.shape.x += Math.sin(bullet.direction) * 5
            bullet.shape.y += Math.cos(bullet.direction) * 5
          
          explode = (bullet) ->
            bullet.exploded = true
            bullet.shape.graphics.drawCircle(0, 0, 200, 2)
            
            for enemy in game.enemies
              if enemy && collision.checkRectCollision(enemy.bitmap, bullet.shape, 0, true)
                enemy.kill(bullet)
            
            setTimeout ->
              bullet.destroy()
            , 1000
          
          if bullet.direction >= 1.5
            if bullet.shape.x >= bullet.mx || bullet.shape.y <= bullet.my
              explode(bullet)
          else if bullet.direction >= 0
            if bullet.shape.x >= bullet.mx || bullet.shape.y >= bullet.my
              explode(bullet)
          else if bullet.direction >= -1.5
            if bullet.shape.x <= bullet.mx || bullet.shape.y >= bullet.my
              explode(bullet)
          else if bullet.direction >= -3
            if bullet.shape.x <= bullet.mx || bullet.shape.y <= bullet.my
              explode(bullet)