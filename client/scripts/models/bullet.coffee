class window.Bullet extends Player
  constructor: (player) ->
    @player = player || game.players[0]
    
    @px = -game.world.x + game.players[0].bitmap.x
    @py = -game.world.y + game.players[0].bitmap.y
    @mx = -game.world.x + game.posx
    @my = -game.world.y + game.posy
    
    console.log @px, @py, @mx, @my
    
    @shape = new createjs.Shape()
    @shape.graphics.beginFill("#FFFF00").drawRect(0, 0, 7, 4)
    @shape.x = -game.world.x + game.players[0].bitmap.x
    @shape.y = -game.world.y + game.players[0].bitmap.y
    
    game.world.addChild @shape
    
    game.bullets.push(@)
  
  @move = (bullet) ->
    bullet.shape.x += -(bullet.px - bullet.mx) / 10
    bullet.shape.y += -(bullet.py - bullet.my) / 10