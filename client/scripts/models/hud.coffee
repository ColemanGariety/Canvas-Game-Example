class window.Hud extends Game
  constructor: ->
    # Ammo
    @ammo = new createjs.Text String(game.players[0].ammo.machinegun), "60px Arial", "#FFF"
    @ammo.textBaseline = "alphabetic"
    @ammo.x = 20
    @ammo.y = 70
    
    # Ammo available
    @cartridges = new createjs.Text String(game.players[0].cartridges.machinegun), "60px Arial", "#FFF"
    @cartridges.textBaseline = "alphabetic"
    @cartridges.x = 150
    @cartridges.y = 70
    
    # Save dat shit
    game.hud = @
    game.stage.addChild game.hud.ammo, game.hud.cartridges
    
  @update = (variable) ->
    switch variable
      when "ammo"
        game.hud.ammo.text = game.players[0].ammo.machinegun
        game.hud.cartridges.text = game.players[0].cartridges.machinegun