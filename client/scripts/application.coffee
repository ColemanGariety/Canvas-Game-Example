# Start the game
game = new Game("gameCanvas")

# Adds some stuff to mess around with
new Continent()
new Player("Jackson", true)

# Spawner
enemySpawner = setInterval ->
  new Enemy()
, (Math.random() * (5000) + 1500)