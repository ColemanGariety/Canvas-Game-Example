# Extend arrays
Array::remove = ->
  what = undefined
  a = arguments
  L = a.length
  ax = undefined
  while L and @length
    what = a[--L]
    @splice ax, 1  while (ax = @indexOf(what)) isnt -1
  this

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