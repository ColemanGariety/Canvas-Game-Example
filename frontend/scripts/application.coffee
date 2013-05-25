class ZombieGame
	constructor: (p_canvasId) ->
		@stage = new createjs.Stage p_canvasId

		@startRenderLoop()

		# Debug code to get started - Remove this
		circle = new createjs.Shape()
		circle.graphics.beginFill("red").drawCircle(0, 0, 50)
		circle.x = 100
		circle.y = 100
		@stage.addChild circle

		@stage.update()

	# TODO: Create render loop
	startRenderLoop: ->


if window? then window.ZombieGame = ZombieGame else if module?.exports? then module.exports = ZombieGame