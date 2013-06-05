class window.Hud extends Game
  constructor: ->
    # Ammo
    @ammo = new createjs.Text String(game.players[0].ammo.machinegun), "20px Arial", "#FFF"
    @ammo.textBaseline = "alphabetic"
    @ammo.x = 50
    @ammo.y = 50
    
    # Ammo available
    @cartridges = new createjs.Text String(game.players[0].cartridges.machinegun), "20px Arial", "#FFF"
    @cartridges.textBaseline = "alphabetic"
    @cartridges.x = 100
    @cartridges.y = 50
    
    # Save dat shit
    game.hud = @
    game.stage.addChild game.hud.ammo, game.hud.cartridges
    
  @update = (variable) ->
    switch variable
      when "ammo"
        game.hud.ammo.text = game.players[0].ammo.machinegun
        game.hud.cartridges.text = game.players[0].cartridges.machinegun