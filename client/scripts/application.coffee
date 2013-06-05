# Start the game
game = new Game("gameCanvas")

# Adds some stuff to mess around with
new Player("Jackson", true)
new Hud()
new Continent()

# Spawner
spawner = ->
  new Enemy() if game.enemies.length < 100
  setTimeout ->
    spawner()
  , Math.random() * 1000

spawner()