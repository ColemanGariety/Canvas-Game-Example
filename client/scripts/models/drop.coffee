class window.Drop
  constructor: (dropper, name) ->
    switch dropper.type
      when "corpse"
        drops = [
          { name: "Machinegun Cartridge", probability: .15  }
          { name: "dollars", probability: .3  }
        ]
    
    drops.sort (a, b) ->
      a.probability - b.probability
    
    rand = Math.random()
    
    for drop in drops
      if drop.probability >= rand
        @name = drop.name
        break
    
    if @name
      switch @name
        when "Machinegun Cartridge"
          @shape = new createjs.Shape()
          @shape.graphics.beginFill("#000").drawRect(0, 0, 7, 14)
          @shape.x = dropper.bitmap.x
          @shape.y = dropper.bitmap.y
          
          game.world.addChild(@shape)
          game.drops.push(@)
        
          console.log "#{dropper.name} dropped a #{@name}"
  
  @pickup = (player, drop) ->
    game.world.removeChild drop.shape
    game.drops.splice(game.drops.indexOf(drop), 1)
    
    switch drop.name
      when "Machinegun Cartridge"
        player.cartridges.machinegun++
        Hud.update("ammo")
        createjs.Sound.play "/audio/reload.m4a"
  
    console.log "#{player.name} picked up a #{drop.name}"