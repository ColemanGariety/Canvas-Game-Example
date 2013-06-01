class window.Continent extends Game
  constructor: (name) ->
    @name = name || "Homeland"

    @x = 0
    @y = 0

    @bitmap = new Image()
    @bitmap.src = "images/grass.jpg"

    @shape = new createjs.Shape()
    @shape.graphics.beginBitmapFill(@bitmap, "repeat").drawRect(0, 0, 40000, 40000)

    game.world.addChild(@shape);