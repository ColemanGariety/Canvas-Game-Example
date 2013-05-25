# Describes the various characters within the game
Characters =
	Human:
		movementSpeed: 1
		maximumHealth: 100
		asset: new createjs.Shape().circle.graphics.beginFill("red").drawCircle(0, 0, 50)
	Zombie:
		movementSpeed: 0.2
		maximumHealth: 20
		asset: new createjs.Shape().circle.graphics.beginFill("blue").drawCircle(0, 0, 50)

module.exports = Characters