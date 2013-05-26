BaseView = require "./baseView"

# 
class Character extends BaseView
	constructor: (p_options) ->
		super p_options

		@model.on "character.weapon.changed", render
		@model.on "character.armor.changed", render

	# TODO: Have this method render the character's currently equipped weapons / armor
	render: ->
